# Microsoft Take Home Assignment (0/11)

## Things to mention
- Handle events stretching across the day
- How to handle midnight re-jiggering all the indices (there's an NSNOtification for significant date changes)
- https://staxmanade.com/2015/06/debugging-ios-autolayout-issues/
- PresenceView needs to be better at handling > 100 avatars (I still add them as subviews which is stupid)
- Feedback generator


## Things to check at the end
- [x] Style inconsistencies
	- [x] Using NSLayoutConstraints.activate() vs. manual isActives
	- [x] .init vs. just Type()
	- [x] UIFont.monospacedDigitSystemFont(ofSize: <#T##CGFloat#>, weight: <#T##UIFont.Weight#>) extension
- [x] Make nice folders/groups

## Primitives

- [x] Date Cell for calendar collection views
	- x ] Odd Months - don't forget to unit test the logic for "odd"/"even" months
	- [x] Don't forget to use SF Monospace numbers!
	- [x] Remove all hardcoded strings and constants
	- [x] Even Months
	- [x] Start of month (Need to have month's name) - unit test (Model -> Presenter) logic
	- [ ] event marker

- [x] Table View Cell for Event Views
	- [x] _No events_
	- [x] Multiple events - default with title and stuff
	- [x] Multiple events with attendees
	- [x] Holidays that are all day


## Bare Minimums

- [ ] Overlay thing on top of months as you scroll
- [x] Move date indicator as you scroll
- [x] Sync scrolling of events table -> calendar
- [x] Tapping on date -> scroll in events table view
- [x] Expand/Contract calendar and events table view

## Bonus points

- [x] DateHeaderView blue highlights
- [x] Forecast.io API integrationForecast.io
	- [x] Don't forget to make sure NSURLSession calls back in the correct thread 
	- [x] Add tests for network API calls - mock URLsession object should do the trick
	- [x] Decode service API with Codable protocol
- [ ] Add view to show weather inside table view
	- [ ] Showing multiple loaders in each day? 🤔
	- [ ] See if forecast lets you get multiple days
	- [ ] Otherwise just show today's forecast
- [x] Dynamic type support
