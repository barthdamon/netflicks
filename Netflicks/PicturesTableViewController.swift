//
//  PicturesTableViewController.swift
//  Netflicks
//
//  Created by Matthew Barth on 7/28/15.
//  Copyright (c) 2015 Matthew Barth. All rights reserved.
//

import UIKit

class PicturesTableViewController: UITableViewController {

    var shows: [show]!
    var indexShow: show!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting nav item
        let logo = UIImage(named: "fav.png")
        var favorites : UIBarButtonItem = UIBarButtonItem(image: logo, style: UIBarButtonItemStyle.Plain, target: self, action: "favoritesTapped")
        favorites.tintColor = hexStringToUIColor("#ECECEC")
        self.navigationItem.leftBarButtonItem = favorites
        
        //Next steps: load actual live data, load full video, user authentication, see what your friends favorites are, and slider menu options
        
        setUpData()
        
    }
    
    func setUpData() {
        //this data is so hardcoded it would take three blue diamond pickaxes to break...
        
        //modernish
        let house = show(type: categoryType.modern, featureFilm: false, url: "https://en.wikipedia.org/wiki/House_of_Cards_(U.S._TV_series)", tubeUrl: "https://www.youtube.com/watch?v=sU9QTLXYCCc", imagePath: UIImage(named: "house.png")!, title: "House of Cards", comments: "Frank Underwood gets shit done. Although sometimes it is easy to disagree with his methods, in the end he makes things happen. The show sheds a new light on what it takes to be a politician, and makes the viewer question what traits they actually value in their political representatives.")
        let pulp = show(type: categoryType.modern, featureFilm: true, url: "https://en.wikipedia.org/wiki/Pulp_Fiction", tubeUrl: "https://www.youtube.com/watch?v=s7EdQ4FqbhY", imagePath: UIImage(named: "pulp.png")!, title: "Pulp Fiction", comments: "Scorsese at his best. It's a messed up movie but it makes you think.")
        let top = show(type: categoryType.modern, featureFilm: true, url: "https://en.wikipedia.org/wiki/Top_Gun", tubeUrl: "https://www.youtube.com/watch?v=qAfbp3YX9F0", imagePath: UIImage(named: "top.png")!, title: "Top Gun", comments: "Iahhhh went to the danger zone. Great piano scene, and great vibes. The rivalries all become friendships when the pilots face their true enemies.")
        
        //history
        let peaky = show(type: categoryType.history, featureFilm: false, url: "https://en.wikipedia.org/wiki/Peaky_Blinders_(TV_series)", tubeUrl: "https://www.youtube.com/watch?v=EM12mcTEI88", imagePath: UIImage(named: "peaky.png")!, title: "Peaky Blinders", comments: "Gotta love some gang wars. Sort of like an old school Green Street Hooligans. The main character takes exterme risks, but they are all delicately planned.")
        let story = show(type: categoryType.history, featureFilm: false, url: "https://en.wikipedia.org/wiki/America:_The_Story_of_Us", tubeUrl: "https://www.youtube.com/watch?v=Wk1nrgm55gQ", imagePath: UIImage(named: "story.png")!, title: "History of US", comments: "Highlights some of the ambitious pioneers throughout history that have pushed America forward. Also does a good job at recognizing the struggles of countless of nameless heros that have made America what it is today.")
        let turn = show(type: categoryType.history, featureFilm: false, url: "https://en.wikipedia.org/wiki/Turn:_Washington%27s_Spies", tubeUrl: "https://www.youtube.com/watch?v=NlqFOHh4Ra4", imagePath: UIImage(named: "turn.png")!, title: "Turn", comments: "History is awesome. So inspiring to see what the founding fathers had to go through. Really fun to watch.")
        
        //funny
        let trailer = show(type: categoryType.funny, featureFilm: false, url: "https://en.wikipedia.org/wiki/Trailer_Park_Boys", tubeUrl: "https://www.youtube.com/watch?v=O7cSKNevYQc", imagePath: UIImage(named: "trailer.png")!, title: "Trailer Park Boys", comments: "These guys are total idiots, but they also look out for each other. Really funny watching the way they choose to irresponsibly live their lives, and it is calming comparing their rediculous problems to your own.")
        let that = show(type: categoryType.funny, featureFilm: false, url: "https://en.wikipedia.org/wiki/That_%2770s_Show", tubeUrl: "https://www.youtube.com/watch?v=fexFiXfrIjo",imagePath: UIImage(named: "that.png")!, title: "That 70's Show", comments: "Life is all about having fun, learning from mistakes, and making friends. It's important to hold on to the same enthusiasm, curiosity, and energy that comes with being a kid, even after becoming an adult.")
        let interview = show(type: categoryType.funny, featureFilm: true, url: "https://en.wikipedia.org/wiki/The_Interview_(2014_film)", tubeUrl: "https://www.youtube.com/watch?v=Mj3uHftd5FQ", imagePath: UIImage(named: "interview.png")!, title: "The Interview", comments: "Not as good as Team America (which makes fun of both the US and North Korea), but still pretty funny.")
        
        
        shows = [house, pulp, top, peaky, story, turn, trailer, that, interview]
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 3
    }
    
    override func tableView( tableView : UITableView,  titleForHeaderInSection section: Int)->String
    {
        switch(section)
        {
        case 0:
            return "Modern"
        case 1:
            return "History"
        case 2:
            return "Funny"
        default :
            return "What is this doing here...?"
        }
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor.blackColor()
        header.textLabel.textColor = UIColor.whiteColor() //make the text white
       // header.textLabel.textAlignment = .Center
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 1
    }
    
    func favSendToDetail(title: String) {
        //going through the shows to find the title selected in fav controller, only gonna be one, but it'll be there
        let detailShow = shows.filter { $0.title == title }
        sendToDetail(detailShow[0])
    }
    
    func sendToDetail(sender: show) {
        self.indexShow = sender
        performSegueWithIdentifier("showDetail", sender: self)
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("contentCell", forIndexPath: indexPath) as! CustomTableViewCell
        cell.sendToDetail = self.sendToDetail
        cell.selectionStyle = .None
        
        switch indexPath.section {
        case 0:
            cell.sectionShows = shows.filter { $0.type == categoryType.modern }
        case 1:
            cell.sectionShows = shows.filter { $0.type == categoryType.history }
        case 2:
            cell.sectionShows = shows.filter { $0.type == categoryType.funny }
        default:
            //bah bah bah
            break
        }

        return cell
    }
    
    //MARK: navigation
    
    func favoritesTapped() {
        performSegueWithIdentifier("showFavs", sender: self)
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let detailController = segue.destinationViewController as! DetailViewController
            detailController.detailShow = indexShow
        }
        
        if segue.identifier == "showFavs" {
            //configure favs controller
            let favsController = segue.destinationViewController as! FavsViewController
            favsController.sendToDetail = favSendToDetail
        }
    }
}
