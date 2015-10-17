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
    var tabBar:UITabBarController = UITabBarController()
    
    override init(style: UITableViewStyle, className: String!)
    {
        super.init(style: style, className: className)
        
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
        self.objectsPerPage = 25
        
        self.parseClassName = className
        
        // Add button to post
        
        let toolbar = UIToolbar()
        toolbar.frame = CGRectMake(0, self.view.frame.size.height - (75 * 1.5), self.view.frame.size.width, 75)
        toolbar.layer.zPosition = 100
        
        let postButton = UIButton(type: UIButtonType.System)
        postButton.frame = CGRectMake(toolbar.frame.size.width / 2, toolbar.frame.size.height / 2, toolbar.frame.size.height / 2, toolbar.frame.size.height / 2)
        postButton.backgroundColor = UIColor.blueColor()
        postButton.setTitle("NP", forState: UIControlState.Normal)
        postButton.addTarget(self, action: "showPostView", forControlEvents: UIControlEvents.TouchUpInside)
        postButton.layer.zPosition = 100
        
        let barButton = UIBarButtonItem(customView: postButton)
        toolbar.setItems([barButton], animated: true)
        self.view.addSubview(toolbar)
    }
    
    func showPostView() {
        let v = PostStoryViewController()
        v.view.backgroundColor = UIColor.blackColor()
        self.presentViewController(v, animated: true, completion: nil)
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
            
            if(uid == (obj.valueForKey("objectId") as? String)) {
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
            let dateCreated : String = dateToString(tmpObj.valueForKey("createdAt") as! NSDate)
            let postContent : String = (tmpObj.valueForKey("content") as! String)
            
            let first = PostViewController(postedBy: postedBy, postTitle: postTitle, postLikes: postLikes, comments: comments, datePosted: dateCreated, content: postContent)
            first.view.backgroundColor = UIColor.lightGrayColor()
            let second = CommentsViewController(comments: comments)
            second.view.backgroundColor = UIColor.greenColor()
            let test = ContentTabBarControllerViewController(arrControllers: [first, second])
            test.navigationItem.title = "Back"
            self.navigationController?.pushViewController(test, animated: true)
            
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
        
        query.orderByAscending("objectId")
        
        return query
    }
    
    func dateToString(date : NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .MediumStyle
        
        return dateFormatter.stringFromDate(date)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        let cellIdentifier:String = "Cell"
        
        var cell:PFTableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? PFTableViewCell
        
        if(cell == nil) {
            cell = PFTableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellIdentifier)
        }
        
        if let pfObject = object {
            // Create title by appending title to uid
            let uid : String = pfObject.valueForKey("objectId") as! String
            let title : String = pfObject.valueForKey("title") as! String
            cell?.textLabel?.text = uid + ". " + title
            
            // If object is valid, add it to array
            let likes = pfObject.valueForKey("likes") as! Int
            let numComments = (pfObject.valueForKey("comments") as! [String]).count
            cell?.detailTextLabel?.text = "Points " + String(likes) + " • Comments: " + String(numComments)
            objectsArray.append(pfObject);
        }
        
        return cell;
    }

}
