//
//  DetailViewController.swift
//  XboxReplica
//
//  Created by Matthew Barth on 7/28/15.
//  Copyright (c) 2015 Matthew Barth. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var detailShow: show!
    var favorites: UIBarButtonItem!
    var favoriteShowsList: [show]!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //first querying favorite showobject and see if it already exists, then setting color of menu depending on if detailShow is already a fav
        if NSUserDefaults.standardUserDefaults().objectForKey("favs") != nil {
            favoriteShowsList = NSUserDefaults.standardUserDefaults().objectForKey("favs") as! [show]
        }
    
        
        let logo = UIImage(named: "fav.png")
        favorites = UIBarButtonItem(image: logo, style: UIBarButtonItemStyle.Plain, target: self, action: "favoritesTapped")
        favorites.tintColor = hexStringToUIColor("#5B615B")
        self.navigationItem.rightBarButtonItem = favorites
        
        //show specific setup
        imageView.image = detailShow.imagePath
        titleLabel.text = detailShow.title
        descriptionLabel.text = detailShow.comments
    }
    
    func favoritesTapped() {
        //update dat bish
        favoriteShowsList.append(detailShow)
        NSUserDefaults.standardUserDefaults().setObject(favoriteShowsList, forKey: "favs")
        
        self.alertShow("Favorite Added", alertMessage: "U Rike??")
        favorites.tintColor = hexStringToUIColor("#C40000")
    }
    
    //I just have this clipboarded as a function, makes it easier in some projects
    func alertShow(alertText :String, alertMessage :String) {
        var alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        //can add another action (maybe cancel, here)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func sendToWikipedia() {
        performSegueWithIdentifier("showWeb", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showWeb" {
            let webViewController = segue.destinationViewController as! WebViewController
            webViewController.url = detailShow.url
        }
    }

    @IBAction func webBtnClicked(sender: AnyObject) {
        sendToWikipedia()
    }
}



//Just really wanted to use a hexcode color, haha. setting rgb values is a pain honestly. I could see it being useful for color animations. I just use Frank Deloupe though. hexcode is wayyy easier.
func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
    
    if (cString.hasPrefix("#")) {
        cString = cString.substringFromIndex(advance(cString.startIndex, 1))
    }
    
    if (count(cString) != 6) {
        return UIColor.grayColor()
    }
    
    var rgbValue:UInt32 = 0
    NSScanner(string: cString).scanHexInt(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

