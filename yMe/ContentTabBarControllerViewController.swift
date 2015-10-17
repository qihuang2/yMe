//
//  ContentTabBarControllerViewController.swift
//  yMe
//
//  Created by Qi Feng Huang on 10/16/15.
//  Copyright © 2015 hackathon. All rights reserved.
//

import UIKit

class ContentTabBarControllerViewController: UITabBarController{
    let objId:String
    var view2:CommentsViewController
    
    init(arrControllers : [UIViewController], objectId: String){
        self.objId = objectId
        
        let view1 = arrControllers[0]
        view2 = arrControllers[1] as! CommentsViewController
        
        super.init(nibName: nil, bundle: nil)
        
        
        view1.tabBarItem = UITabBarItem(title: "First", image: nil, tag: 0)
        view2.tabBarItem = UITabBarItem(title: "Second", image: nil, tag: 0)
        
        // Add comment button
        let commentButton = UIBarButtonItem(title: "Comment", style: UIBarButtonItemStyle.Done, target: self, action: "showCommentController")
        self.navigationItem.rightBarButtonItem = commentButton
        
        self.viewControllers = [view1, view2]
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showCommentController() {
        let commentController = AddCommentViewController(objectid: objId, commentArray: view2.comments)
        commentController.view.backgroundColor = UIColor.lightGrayColor()
        self.presentViewController(commentController, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
