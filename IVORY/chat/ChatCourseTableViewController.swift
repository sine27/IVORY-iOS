//
//  ChatCourceTableViewController.swift
//  IVORY
//
//  Created by Shayin Feng on 1/12/16.
//  Copyright © 2016 ZengJintao. All rights reserved.
//

import UIKit

class ChatCourseTableViewController: UITableViewController, UISearchBarDelegate {
    
    var searchController: UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: UISearchBar Delegate
    @IBAction func showSearchBar(sender: AnyObject) {
        searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.delegate = self
        presentViewController(searchController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

}
