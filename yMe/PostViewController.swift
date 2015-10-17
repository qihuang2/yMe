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
    let postLikes : Int
    let comments : [String]
    let datePosted : String
    let content : String
    
    init(postedBy: String, postTitle: String, postLikes : Int, comments : [String], datePosted : String, content : String) {
        self.postedBy = postedBy
        self.postTitle = postTitle
        self.postLikes = postLikes
        self.comments = comments
        self.datePosted = datePosted
        self.content = content
        super.init(nibName: nil, bundle: nil)
        
        let leftLoc : CGFloat = 25
        let topLoc : CGFloat = 50
        
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
        print("PostViewController loaded")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
