//
//  PostViewController.swift
//  yMe
//
//  Created by V on 10/16/15.
//  Copyright © 2015 hackathon. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    
    var barController : UITabBarController = UITabBarController()
    
    let postedBy : String
    let postTitle : String
    var postLikes : Int
    let comments : [String]
    let datePosted : String
    let content : String
    let likeLabel = UILabel()
    
    let leftLoc : CGFloat = 25
    let topLoc : CGFloat = 50
    let objId:String
    
    init(postedBy: String, postTitle: String, postLikes : Int, comments : [String], datePosted : String, content : String, objectId: String) {
        self.postedBy = postedBy
        self.postTitle = postTitle
        self.postLikes = postLikes
        self.comments = comments
        self.datePosted = datePosted
        self.content = content
        self.objId = objectId
        super.init(nibName: nil, bundle: nil)
        
        let textFont = UIFont(name: "Arial", size: 12)
        
        let titleLabel = UILabel(frame: CGRectMake(leftLoc, topLoc, self.view.frame.size.width * 3/4, 100))
        titleLabel.text = "Title: " + self.postTitle
        titleLabel.font = textFont
        
        let posterLabel = UILabel(frame: CGRectMake(leftLoc, topLoc * 1.5, self.view.frame.size.width * 3/4, 100))
        posterLabel.text = "Posted By: " + self.postedBy
        posterLabel.font = textFont
        
        let dateLabel = UILabel(frame: CGRectMake(leftLoc, topLoc * 2, self.view.frame.size.width * 3/4, 100))
        dateLabel.text = "Date Posted: " + self.datePosted
        dateLabel.font = textFont
        
        let contentLabel = UITextView(frame: CGRectMake(leftLoc, topLoc * 4, self.view.frame.size.width - (2 * leftLoc), self.view.frame.size.height - (topLoc * 4) - 100))
        contentLabel.text = self.content
        contentLabel.editable = false
        contentLabel.font = textFont
        
        
        likeLabel.frame = CGRect(x: self.view.frame.size.width - leftLoc * 4.15, y: topLoc * 1.5, width: 100, height: 100)
        likeLabel.textColor = (self.postLikes >= 0) ? UIColor.greenColor() : UIColor.redColor()
        
        
        likeLabel.text = String(self.postLikes)
        
        
        self.view.addSubview(likeLabel)
        self.view.addSubview(titleLabel)
        self.view.addSubview(posterLabel)
        self.view.addSubview(dateLabel)
        self.view.addSubview(contentLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let buttonSideLength:CGFloat = 45
        
        print("PostViewController loaded")
        
        let upvoteButton = UIButton(frame: CGRect(x: self.view.frame.size.width - leftLoc - buttonSideLength, y: topLoc*1.53, width: buttonSideLength, height: buttonSideLength))
        upvoteButton.backgroundColor = UIColor.greenColor()
        
        upvoteButton.addTarget(self, action: "upvote", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(upvoteButton)
        
        let downvoteButton = UIButton(frame: CGRect(x: self.view.frame.size.width - leftLoc - buttonSideLength, y: topLoc*2.53, width: buttonSideLength, height: buttonSideLength))
        downvoteButton.backgroundColor = UIColor.redColor()
        
        self.view.addSubview(downvoteButton)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func upvote(){
        self.postLikes++
        self.likeLabel.text = ("\(self.postLikes)")
        likeLabel.textColor = (self.postLikes >= 0) ? UIColor.greenColor() : UIColor.redColor()
        let query = PFQuery(className:"Post")
        query.getObjectInBackgroundWithId(self.objId) {
            (gameScore: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let gameScore = gameScore {
                gameScore.setObject(self.postLikes, forKey: "likes")
                gameScore.saveInBackground()
            }
        }

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
