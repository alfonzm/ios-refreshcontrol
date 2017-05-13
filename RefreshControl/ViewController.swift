//
//  ViewController.swift
//  RefreshControl
//
//  Created by Alfonz Montelibano on 5/13/17.
//  Copyright © 2017 alphonsus. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

	// Outlets
	@IBOutlet weak var tableView: UITableView!
	
	// Data
	var items = ["hello", "world"]
	
	// UI
	var refreshControl: UIRefreshControl = UIRefreshControl()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.tableView.dataSource = self
		
		refreshControl.addTarget(self, action: #selector(ViewController.refreshData), for: UIControlEvents.valueChanged)
		
		if #available(iOS 10.0, *) {
			tableView.refreshControl = refreshControl
		} else {
			tableView.addSubview(refreshControl)
		}
	}
	
	func refreshData() {
		items.append("new")
		tableView.reloadData()
		refreshControl.endRefreshing()
	}

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
}

