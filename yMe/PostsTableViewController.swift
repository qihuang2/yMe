//
//  PostsTableViewController.swift
//  yMe
//
//  Created by Qi Feng Huang on 10/16/15.
//  Copyright © 2015 hackathon. All rights reserved.
//

import UIKit

class PostsTableViewController: PFQueryTableViewController {

    var objectsArray:[PFObject] = []
    
    override init(style: UITableViewStyle, className: String!)
    {
        super.init(style: style, className: className)
        
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
        self.objectsPerPage = 25
        
        self.parseClassName = className
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let tappedCell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        
        var referringObject: PFObject?
        for obj: PFObject in objectsArray {
            var uid : String = tappedCell.textLabel!.text!
            uid = uid.componentsSeparatedByString(".")[0]
            
            if(uid == (obj["uid"] as? String)) {
                referringObject = obj
            }
        }
        
        if var str : String = referringObject?["content"] as? String {
            // Object found, retreive and display info
            
        }else {
            print("Not found")
        }
        
        //CODE TO BE RUN ON CELL TOUCH
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func queryForTable() -> PFQuery {
        print("Q");
        let query:PFQuery = PFQuery(className:self.parseClassName!)
        
        if(objects?.count == 0)
        {
            query.cachePolicy = PFCachePolicy.CacheThenNetwork
        }
        
        query.orderByAscending("title")
        
        return query
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        let cellIdentifier:String = "Cell"
        
        var cell:PFTableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? PFTableViewCell
        
        if(cell == nil) {
            cell = PFTableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellIdentifier)
        }
        
        if let pfObject = object {
            // Create title by appending title to uid
            let uid : String = pfObject["uid"] as! String
            let title : String = pfObject["title"] as! String
            cell?.textLabel?.text = uid + ". " + title
            
            // If object is valid, add it to array
            let likes = pfObject["likes"] as! Int
            let numComments = (pfObject["comments"] as! [String]).count
            cell?.detailTextLabel?.text = "Likes " + String(likes) + " : Comments: " + String(numComments)
            objectsArray.append(pfObject);
        }
        
        return cell;
    }

}
