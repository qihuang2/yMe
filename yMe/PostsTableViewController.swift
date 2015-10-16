//
//  PostsTableViewController.swift
//  yMe
//
//  Created by Qi Feng Huang on 10/16/15.
//  Copyright © 2015 hackathon. All rights reserved.
//

import UIKit
import Foundation

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
            
            if(uid == (obj.valueForKey("uid") as? String)) {
                referringObject = obj
            }
        }
        
        
        if let tmpObj = referringObject {
            print("Selected")
            // Object found, retreive and display info
            let postedBy : String = tmpObj.valueForKey("cc_by") as! String
            let postTitle : String = tmpObj.valueForKey("title") as! String
            let postLikes : Int = tmpObj.valueForKey("likes") as! Int
            let comments : [String] = (tmpObj.valueForKey("comments") as! [String])
            
            //let dateCreated : NSDate = tmpObj["createdAt"] as! NSDate
            
            let postViewController = PostViewController(postedBy: postedBy, postTitle: postTitle, postLikes: postLikes, comments: comments)
            let commentsViewController = CommentsViewController()
            
            let tabController = UITabBarController()
            let controllers = [postViewController, commentsViewController]
            tabBarController?.viewControllers = controllers
            tabBarController?.view.backgroundColor = UIColor.blueColor()
            
            self.presentViewController(tabController, animated: false, completion: nil)
            
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
            let uid : String = pfObject.valueForKey("uid") as! String
            let title : String = pfObject.valueForKey("title") as! String
            cell?.textLabel?.text = uid + ". " + title
            
            // If object is valid, add it to array
            let likes = pfObject.valueForKey("likes") as! Int
            let numComments = (pfObject.valueForKey("comments") as! [String]).count
            cell?.detailTextLabel?.text = "Likes " + String(likes) + " : Comments: " + String(numComments)
            objectsArray.append(pfObject);
        }
        
        return cell;
    }

}
