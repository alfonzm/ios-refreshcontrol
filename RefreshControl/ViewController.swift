//
//  ViewController.swift
//  RefreshControl
//
//  Created by Alfonz Montelibano on 5/13/17.
//  Copyright © 2017 alphonsus. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

	// Outlets
	@IBOutlet weak var tableView: UITableView!
	
	// Data
	var items = ["hello", "world"]
	
	// UI
	var refreshControl: UIRefreshControl = UIRefreshControl()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.tableView.dataSource = self
		self.tableView.delegate = self
		
		refreshControl.addTarget(self, action: #selector(ViewController.refreshData), for: UIControlEvents.valueChanged)
		refreshControl.tintColor = .lightGray
		setRefreshControlText("Pull to refresh...")
		
		if #available(iOS 10.0, *) {
			tableView.refreshControl = refreshControl
		} else {
			tableView.addSubview(refreshControl)
		}
	}
	
	func refreshData() {
		// Simulate asynchronous data fetch
		DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
			self.items.append("new")
			self.tableView.reloadData()
			self.setRefreshControlText("Pull to refresh...")
			self.refreshControl.endRefreshing()
		})
	}

	// MARK: TableView data source
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
		
		if cell == nil {
			cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
		}
		
		cell?.textLabel?.text = items[indexPath.item]
		
		return cell!
	}
	
	// Refresh control scroll view
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let offset = scrollView.contentOffset.y
		
		if offset < -150 {
			setRefreshControlText("Loading...")
		}
	}
	
	func setRefreshControlText(_ text: String) {
		refreshControl.attributedTitle = NSAttributedString(string: text, attributes: [NSForegroundColorAttributeName: refreshControl.tintColor])
	}
}
