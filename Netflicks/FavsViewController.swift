//
//  FavsViewController.swift
//  Netflicks
//
//  Created by Matthew Barth on 7/28/15.
//  Copyright (c) 2015 Matthew Barth. All rights reserved.
//

import UIKit

class FavsViewController: UITableViewController {
    
    var favoriteShowTitlesList: [String]!
    var sendToDetail:( (title: String) -> ())!

    override func viewDidLoad() {
        super.viewDidLoad()

        //gather the favs!
        if NSUserDefaults.standardUserDefaults().objectForKey("favs") != nil {
            favoriteShowTitlesList = NSUserDefaults.standardUserDefaults().objectForKey("favs") as! [String]
        }
    }
  
  func viewDidAppear() {
    super.viewDidAppear(true)
    favoriteShowTitlesList = nil
    
    //gather the favs!
    if NSUserDefaults.standardUserDefaults().objectForKey("favs") != nil {
      favoriteShowTitlesList = NSUserDefaults.standardUserDefaults().objectForKey("favs") as! [String]
    }
  }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return favoriteShowTitlesList == nil ? 0 : count(favoriteShowTitlesList)
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor.blackColor()
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("favCell", forIndexPath: indexPath) as! CustomFavTableViewCell
        cell.textLabel!.text = favoriteShowTitlesList[indexPath.row]
        return cell
    }


    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }


    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            favoriteShowTitlesList.removeAtIndex(indexPath.row)
            NSUserDefaults.standardUserDefaults().setObject(favoriteShowTitlesList, forKey: "favs")
            tableView.reloadData()
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        let title = cell?.textLabel?.text
        sendToDetail(title: title!)
    }

}
