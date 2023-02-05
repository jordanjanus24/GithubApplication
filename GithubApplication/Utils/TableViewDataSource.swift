//
//  TableViewDataSource.swift
//  GithubApplication
//
//  Created by Janus Jordan on 2/4/23.
//

import Foundation
import UIKit


// NOTE: Table Data Source for Single Cell
// This method is currently unused, just want to keep this for future reference.
class SingleReusableTableDataSource<Cell: ReusableCell, T> : NSObject, UITableViewDataSource {
    private var tableView: UITableView!
    private var items : [T]!
    var configureCell : (Cell, T) -> () = { _,_ in }
    var count: Int!
    init(_ tableView: UITableView, items : [T], configureCell : @escaping (Cell, T) -> ()) {
        self.tableView = tableView
        self.items =  items
        self.configureCell = configureCell
        self.count = items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.self.reuseIdentifier, for: indexPath) as! Cell
        self.configureCell(cell, self.items[indexPath.row])
        return cell as! UITableViewCell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Cell.self.cellHeight
    }
    func reloadWithData(items: [T]) {
        self.items = items
        self.count = items.count
        self.tableView.reloadData()
    }
}

// NOTE: Table Data Source for Multiple Cells with Different Classes
class BasicReusableTableDataSource<T> : NSObject, UITableViewDataSource {
    private var tableView: UITableView!
    private var items : [T?]!
    var configureCell : (UITableView, T?, IndexPath) -> (ReusableCell)?
    var count: Int!
    private var numberOfSections = 1
    private var showBottomSection = false
    init(_ tableView: UITableView, items : [T?], numberOfSections: Int = 1, configureCell : @escaping (UITableView, T?, IndexPath) -> (ReusableCell)) {
        self.tableView = tableView
        self.items =  items
        self.configureCell = configureCell
        self.count = items.count
        self.numberOfSections = numberOfSections
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = self.configureCell(tableView, items[indexPath.row], indexPath)
            return cell as! UITableViewCell
        } else {
            let cell = self.configureCell(tableView, nil, indexPath)
            return cell as! UITableViewCell
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.numberOfSections
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return items.count
        } else {
            return showBottomSection == true ? 1 : 0
        }
    }
    func showBottomSection(show: Bool) {
        self.showBottomSection = show
        self.tableView.reloadData()
    }
    func reloadWithData(items: [T]) {
        self.items = items
        self.count = items.count
        self.tableView.reloadData()
    }
}

