# Hi Outlook folks 👋!

I'm Robin, and first of all I'd like to thank you for letting me participate in your iOS engineer challenge. It's been a lot of fun, and honestly I've learnt a lot.


# Goals

Our aim in this challenge is to implement the Calendar/Agenda view as seen in the Outlook iOS app. I've tried my best to be faithful to the original design, and I've pointed out places where I've made different choices and added/removed features. There's also places where I've cut-out non essential features, but still try to articulate how I'd implement them if I had the time

# Stuff I've added to the app

- **Dynamic Type** Almost all the views in the app support dynamic type + expanded content. From the calendar cells to the labels in the agenda view.
- **Attendees View** now shows as many attendees as possible, not limited to 5 avatars. In addition, this view also scales with dynamic type, using the size of the "+13" label as a reference
- **Date limits** The dates in the calendar extend to ~5 years before and after the current date
- **Feedback Generator** I've added a light impact feedback generator so that scrolling the agenda view feels like scrolling through a UIDatePicker

# Let's look at the app

Let's divide the screen into two parts - the "Calendar" view "Agenda" view. Here's my first instinct on seeing the screen:

- The Calendar View is _probably_ a `UICollectionView`, where each cell is a Cell that displays the Day. There's a cell we have to "highlight" (premonitions, anyone? 😉) that's the top date in the Agenda view. Some key features I noticed:-
  - Odd and even days have different background colors
  - The first day of the month shows the month name
- The Agenda View is _probably_ a `TableView`, where the day title is sticky, and there can possibly be multiple events per day. The events :-
  - can (optional) have locations
  - can (optional) have a list of attendees
  - can either be All-day events (like a national holiday), or can have a start time and a duration

In addition, dragging on either view causes the other view to collapse with an animation

# Styling

In order to figure out things like margins, cell sizes etc, I tried overlaying rectangles on top of screenshots (Check out the "Outlook Mobile screens for reference" sketch file in the repo). Also I used [Sip](http://sipapp.io) to grab colors for use in the app.

For things like text sizes, I'm a heavy supporter of Dynamic type (the current Outlook app doesn't seem to support it 😕), so I matched font sizes to 's UI style guidelines from their design resources. So, a 16pt UILabel now corresponds to a `UIFontTextStyle.callout`.

To structure this in code, I took inspiration from [Githawk](https://github.com/GitHawkApp/GitHawk), where all the styles are represented as [static properties in an enum](https://github.com/GitHawkApp/GitHawk/blob/master/Classes/Views/Styles.swift). This has 2 benefits - static properties are lazily evaluated and cached, and allows for easier namespacing too 🎉.

# Architecture

For this project we're going to adopt a very standard, no-frills MVC pattern, as [Dave Delong](https://davedelong.com/blog/2017/11/06/a-better-mvc-part-1-the-problems/) intended. We'll try our best to keep things as testable as possible while staying true to the platform.


# Model

This project suggests using a static data source for events, and we're probably going to need O(1) access for each day's events. So, a dictionary probably makes most sense for us right now

// NOTE: We'll be changing this later, so don't judge my bad choice of types for the dictionary keys please 😜 

```swift
// It's a var so we can set events relative to the current day
var staticEventsDataSet: [Date: [EventViewModel]] = [:]

```

In the future, we'd probably want to replace these static events with an actual dataSource, such as `EventKit` or possibly a REST API. So it makes to abstact away this information into a protocol for easy decoupling and testability.

```swift
protocol EventDataProvider {
	func loadEvents(from startDate: Date, to endDate: Date, completion: @escaping ([(Date, [EventViewModel])]) -> Void)
}
```

and for our static data source, we can simply create an array of `(Date, [EventViewModel])` tuples and return these. Refer to `StaticEventsDataProvider.swift` for the implementation


## Events(Presentation Model)

Note: I'm taking my definition of "Presentation Model" from Ben Sandofsky's [post](https://medium.com/@sandofsky/the-presentation-model-6aeaaab607a0). In other contexts, people sometimes refer to these as "View Model"s

By themselves, `EventViewModel`s are simply their titles, timing (either All-Day or with a start time and duration), a `highlightColor` to represent the color of the dot in the cell, an optional location, and an array of Attendees.

I'm not considering an event that extend across multiple days (say an event that starts today and ends tomorrow), since this is just a ViewModel. In the real world, that event would probably be deconstructed into 2 view models, one for each day it stretches across.


# Views

I've made efforts to make sure all of the views work well with dynamic height + locales. Most `UILabel`s support multiple lines of content where necessary, and content generally adapts for accessibility reasons

## Date Header View

This is the table view header. It shows the relevant day in a `.medium` date style. For this view, I've omitted the tiny touch where today's date is highlighted in blue

## Event Timing View

![Event TimingView](./Assets/EventTimingView/)

This view is responsible for displaying the time of an event. 

## Event Details View

This view combines the event title, a view with the Attendees' avatars and a view for the event location in a UIStackView.

## Attendees View

This view shows the avatars of the event Attendees. If it can't fit in all the possible avatars, shows another view that shows the number of leftover avatars. Like other views, it also scales with dynamic type (it does so by measuring the height of the `PlusNumberView`






