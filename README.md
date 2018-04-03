# Hi Outlook folks 👋!

I'm Robin, and first of all I'd like to thank you for letting me participate in your iOS engineer challenge. It's been a lot of fun, and honestly I've learned a lot.

# Goals

Our aim in this challenge is to implement the Calendar/Agenda view as seen in the Outlook iOS app. I've tried my best to be faithful to the original design, and I've pointed out places where I've made different choices and added/removed features. There's also places where I've cut-out non essential features, but still try to articulate how I'd implement them if I had the time.

# Stuff I've improved

- **Dynamic Type** Almost all the views in the app now support dynamic type + expanded content. From the calendar cells to the labels in the agenda view.
![Dynamic Type](https://i.imgur.com/F6rPYcog.png)
- **Attendees View** now shows as many attendees as possible, not limited to 5 avatars. In addition, this view also scales with dynamic type, using the size of the "+\(leftover numbers)" label as a reference.
![Dynamic Type](https://i.imgur.com/Wkg3jOj.png)
![Attendees View Rotation](https://thumbs.gfycat.com/UnequaledHandsomeAfricanclawedfrog-size_restricted.gif)
- **Date limits** The dates in the calendar extend to 1000 days before and after the current date. It's based on a range of offsets, and so it can be extended/contracted as necessary. I did try doing an infinite scroll with pagination, but doing it smoothly is _really_ hard, as evidenced by apps like [Fantastical handling it](https://gfycat.com/MediocreSneakyAlbertosaurus) (notice how they stop scrolling when they need to load in more data).
- **Feedback Generator** I've added a light impact feedback generator so that scrolling the agenda view feels like scrolling through a UIDatePicker
- **Under 250 lines of code** Classes are decoupled for easy testability, and are generally single purpose and small.
- **Forecast API** my Forecast API is well tested, and uses 's new `Codable` protocol for all operations

# Let's look at the app

Let's divide the screen into two parts - the "Calendar" view "Agenda" view. Here's my first instinct on seeing the screen:

- The Calendar View is _probably_ a `UICollectionView`, where each cell is a `UICollectionViewCell` that displays the Day. There's a cell we have to "highlight" (premonitions, anyone? 😉) that's the top date in the Agenda view. Some key features I noticed:-
  - Odd and even days have different background colors
  - The first day of the month shows the month name
- The Agenda View is _probably_ a `TableView`, where the day title is sticky, and there can possibly be multiple events per day. The events can :-
  - have titles
  - (optional) have locations
  - (optional) have a list of attendees
  - either be All-day events (like a national holiday), or can have a start time and a duration

In addition, dragging on either view causes the other view to collapse with an animation

## Styling

In order to figure out things like margins, cell sizes etc, I tried overlaying rectangles on top of screenshots (Check out the "Outlook Mobile screens for reference" sketch file in the repo). Also I used [Sip](http://sipapp.io) to grab colors for use in the app.

For things like text sizes, I'm a heavy supporter of Dynamic type (the current Outlook app doesn't seem to support it 😕), so I matched font sizes to 's UI style guidelines from their design resources. So, a 16pt UILabel now corresponds to a `UIFontTextStyle.callout`.

To structure this in code, I took inspiration from [Githawk](https://github.com/GitHawkApp/GitHawk), where all the styles are represented as [static properties in an enum](https://github.com/GitHawkApp/GitHawk/blob/master/Classes/Views/Styles.swift). This has 2 benefits - static properties are lazily evaluated and cached, and allows for easier namespacing too 🎉.

## Architecture

For this project we're going to adopt a very standard, no-frills MVC pattern, as [Dave Delong](https://davedelong.com/blog/2017/11/06/a-better-mvc-part-1-the-problems/) intended. We'll try our best to keep things as testable as possible while staying true to the platform.

### Model

This project suggests using a static data source for events, and we're probably going to need O(1) access for each day's events. So, a dictionary probably makes most sense for us right now

```swift
// It's a var so we can set events relative to the current day
var staticEventsDataSet: [Date: [EventViewModel]] = [:]

```

But wait 🚨, there's a problem.
`Date` is really a misnomer. It doesn't really represent a day in time, but rather an Instance of time. So if you added an event at 12:00 AM and another at 12:01, they'd get different keys in the dictionary 😱.

In order to fix this, we'll split a `Date` into `DateComponents` and hide things like the hour/minute/second behind a struct. (Refer to Day.swift in the project to see how it's implemented). This also lets us use `DateComponents`' `hashValue` property for the dictionary. So now our events look like

```swift
var staticEventsDataSet: [Day: [EventViewModel]] = [:]
```

In the future, we'd probably want to replace these static events with an actual dataSource, such as `EventKit` or possibly a REST API. So it makes to abstact away this information into a protocol for easy decoupling and testability.

```swift
protocol EventDataProvider {
	func loadEvents(from startDate: Date, to endDate: Date, completion: @escaping ([(Date, [EventViewModel])]) -> Void)
}
```

and for our static data source, we can simply create an array of `(Date, [EventViewModel])` tuples and return these. Refer to `StaticEventsDataProvider.swift` for the implementation


### Events(Presentation Model)

Note: I'm taking my definition of "Presentation Model" from Ben Sandofsky's [post](https://medium.com/@sandofsky/the-presentation-model-6aeaaab607a0). In other contexts, people sometimes refer to these as "View Model"s

By themselves, `EventViewModel`s are simply their titles, timing (either All-Day or with a start time and duration), a `highlightColor` to represent the color of the dot in the cell, an optional location, and an array of Attendees.

I'm not considering an event that extend across multiple days (say an event that starts today and ends tomorrow), since this is just a ViewModel. In the real world, that event would probably be deconstructed into 2 view models, one for each day it stretches across.


### Views

I've made efforts to make sure all of the views work well with dynamic height + locales. Most `UILabel`s support multiple lines of content where necessary, and content generally adapts for accessibility reasons.

Most views have a `configure` method, that takes in a presentation model, and configures the view accordingly. Given more time, these would be a prime target for unit testing (similar to [Githawk's implementation](https://github.com/GitHawkApp/GitHawk/blob/master/FreetimeTests/IssueLabelCellTests.swift) ) since our views have multiple states/configurations where subviews are hidden/shown depending on the presentation model's properties.

# Things I missed out/want to improve

- Better colors for the `DotView` 😛.
- Tests for my UITableViewCell bindings.
- Scrolling quickly in the `UITableView` has a delay scrolling to the right place in the `UICollectionView`. I tried using `layoutAttributes` to get the correct offsets in the collectionView, but that didn't work quite well either.
- I would love to figure out how the "Month Overlay" works (when you start dragging on the calendar view, it shows the months while blurring out the actual calendar). My first theory involved using decoration views(and there's a couple of classes in my project trying to use those), but decoration views in general aren't supposed to depend on data, so I'm not sure how'd it work
- Infinite scrolling would be a nice addition, but it's also kind of a pain to implement ('s calendar app seems to work on black magic for all I know, and even fantastical's implementation seems sub par since it pauses the user scrolling to load new content)
- I'd like to display the weather for each day separately per day, but that'd require a lot of wrangling with the time travel API and pagination. For now, I'm displaying the weather in the navigation controller's titleView
- Use [`UIApplicationSignificantTimeChangeNotification`](https://developer.apple.com/documentation/uikit/uiapplicationsignificanttimechangenotification) to "re-jigger" all the dates once midnight strikes/some major time change happens









