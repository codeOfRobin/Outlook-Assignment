//
//  MyViewController.swift
//  TestingStackViewCells
//
//  Created by Robin Malhotra on 15/03/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

	let eventDataProvider: EventDataProvider

	var events: [Day: [EventViewModel]] = [:]
	//TODO: Needs to be var for midnight date changing reasons
	var today = Date()

	var calendar = Calendar(identifier: .gregorian)
	//mutating a `DateFormatter` is just as expensive as creating one, because changing the calendar, timezone, locale, or format causes new stuff to be loaded
	//the cost of `DateFormatter` comes from it loading up the formatting and region information from ICU
	let headerDateFormatter = DateFormatter()
	let collectionViewDateFormatter = DateFormatter()

	var offsets = -100...100

	//	#A week is always seven days
	//	Currently true, but historically false. A couple of out-of-use calendars, like the Decimal calendar and the Egyptian calendar had weeks that were 7, 8, or even 10 days.
	let numberOfColumns: CGFloat = 7

	let generator = UIImpactFeedbackGenerator(style: .light)

	var indexPathOfHighlightedCell: IndexPath {
		didSet {
			if oldValue != indexPathOfHighlightedCell {
				collectionView.cellForItem(at: indexPathOfHighlightedCell)?.isHighlighted = true
				collectionView.cellForItem(at: oldValue)?.isHighlighted = false
				generator.impactOccurred()
			}
		}
	}

	let tableView = UITableView()
	let collectionView: UICollectionView
	let layout = MonthFlowLayout()
//	let layout = UICollectionViewFlowLayout()

	enum ExpandedView {
		case agenda
		case calendar
	}

	var expandedState: ExpandedView = .agenda

	init(dataProvider: EventDataProvider) {
		self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		// not sure if this is the best way to go to the middle
		self.indexPathOfHighlightedCell = IndexPath(row: 0, section: offsets.count/2)

		self.eventDataProvider = dataProvider
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		let firstDate = calendar.date(byAdding: .day, value: offsets.first ?? 0, to: today)
		let lastDate = calendar.date(byAdding: .day, value: offsets.last ?? 0, to: today)
		eventDataProvider.loadEvents(from: firstDate ?? Date(), to: lastDate ?? Date()) { [weak self] (results) in
			guard let strongSelf = self else {
				return
			}
			strongSelf.events = results.reduce([:], { (dict, arg) in
				let (date, events) = arg
				var copy = dict
				if let day = Day(from: date, calendar: strongSelf.calendar) {
					copy[day] = events
				}
				return copy
			})
			let sectionsToReload = 0..<(strongSelf.offsets.count)
			strongSelf.tableView.reloadSections(IndexSet(integersIn: sectionsToReload), with: .fade)
		}

		headerDateFormatter.dateStyle = .medium
		collectionViewDateFormatter.dateStyle = .short
		calendar.locale = Locale.current

		tableView.dataSource = self
		tableView.register(EventCell.self, forCellReuseIdentifier: "eventCell")
		tableView.register(EmptyEventsTableViewCell.self, forCellReuseIdentifier: "emptyEventsCell")
		tableView.register(DateHeaderView.self, forHeaderFooterViewReuseIdentifier: "header")
		tableView.delegate = self
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.sectionHeaderHeight = UITableViewAutomaticDimension
		tableView.tableFooterView = UIView()

		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.register(DayCell.self, forCellWithReuseIdentifier: "cell")
		collectionView.backgroundColor = .white

		tableView.scrollToRow(at: IndexPath(row: 0, section: offsets.count/2), at: .middle, animated: true)
		view.backgroundColor = .white
		view.addSubview(tableView)
		view.addSubview(collectionView)

		layout.minimumInteritemSpacing = 0.0
		layout.minimumLineSpacing = 0.0
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()

		let width = view.bounds.width - view.safeAreaInsets.left - view.safeAreaInsets.right

		let numberOfRowsToShow: CGFloat = {
			switch expandedState {
			case .agenda:
				return 2
			case .calendar:
				return 5
			}
		}()

		collectionView.frame = CGRect(x: view.safeAreaInsets.left, y: view.safeAreaInsets.top, width: width, height: width / numberOfColumns * numberOfRowsToShow)
		tableView.frame = CGRect(x: collectionView.frame.minX, y: collectionView.frame.maxY, width: width, height: view.bounds.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom - collectionView.frame.height)
	}

	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? DateHeaderView,
		let date = dateFrom(offset: section) else {
			return nil
		}
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .medium
		header.configure(title: headerDateFormatter.string(from: date), shouldHighlight: calendar.isDate(date, equalTo: today, toGranularity: .day))
		return header
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return offsets.count
	}

	func dateFrom(offset: Int) -> Date? {
		if let offset = offsets.element(at: offset),
			let date = calendar.date(byAdding: .day, value: offset, to: today) {
			return date
		} else {
			return nil
		}
	}

	func eventsFromDataset(at index: Int) -> [EventViewModel] {
		if let date = dateFrom(offset: index),
			let day = Day(from: calendar.dateComponents([.day, .month, .year, .era], from: date)),
			let events = events[day] {
			return events
		} else {
			return []
		}
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let events = eventsFromDataset(at: section)
		if events.count > 0 {
			return events.count
		} else {
			return 1
		}
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let events = eventsFromDataset(at: indexPath.section)

		if events.count > 0 {
			guard let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as? EventCell else {
				return UITableViewCell()
			}
			cell.configure(with: events[indexPath.row])
			return cell
		} else {
			guard let cell = tableView.dequeueReusableCell(withIdentifier: "emptyEventsCell", for: indexPath) as? EmptyEventsTableViewCell else {
				return UITableViewCell()
			}
			cell.configure(text: Constants.Strings.noEvents)
			return cell
		}
	}


	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return offsets.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? DayCell else {
			return UICollectionViewCell()
		}
		if let date = dateFrom(offset: indexPath.row) {
			let day = calendar.component(.day, from: date)
			let month = calendar.component(.month, from: date)
			let monthName = calendar.shortMonthSymbols[month - 1]
			cell.configure(with: day, month: monthName, isOdd: (month % 2 == 0))
		}
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		if indexPathOfHighlightedCell == indexPath {
			cell.isHighlighted = true
		}
	}

	func scrollViewDidScroll(_ scrollView: UIScrollView) {

		if scrollView == tableView,
			let firstIndexPath = tableView.indexPathsForVisibleRows?.first,
			self.indexPathOfHighlightedCell != firstIndexPath {
			let collectionViewIndexPath = IndexPath.init(row: firstIndexPath.section, section: 0)
			collectionView.scrollToItem(at: collectionViewIndexPath, at: .bottom, animated: true)
			self.indexPathOfHighlightedCell = collectionViewIndexPath
		}
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		self.indexPathOfHighlightedCell = indexPath
		tableView.scrollToRow(at: IndexPath.init(row: 0, section: indexPath.row), at: .top, animated: true)
	}

	func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		let oldState = self.expandedState
		if scrollView == collectionView {
			self.expandedState = .calendar
		} else if scrollView == tableView {
			self.expandedState = .agenda
		}

		guard oldState != expandedState else {
			return
		}
		self.view.setNeedsLayout()

		// https://developer.apple.com/documentation/uikit/uiview
		// Use of these methods is discouraged. Use the UIViewPropertyAnimator class to perform animations instead.
		let animator = UIViewPropertyAnimator(duration: 0.25, curve: .easeInOut) {
			self.view.layoutIfNeeded()
		}
		animator.startAnimation()
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		if indexPath.row % 7 == 0 {
			let leftOverWidth =  collectionView.bounds.width - floor(collectionView.frame.width/numberOfColumns) * 6
			let size = CGSize(width: leftOverWidth, height: floor(collectionView.frame.width/numberOfColumns))
			return size
		} else {
			let size = CGSize(width: floor(collectionView.frame.width/numberOfColumns), height: floor(collectionView.frame.width/numberOfColumns))
			return size
		}
	}

}


