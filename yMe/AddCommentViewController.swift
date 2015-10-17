//
//  AddCommentViewController.swift
//  yMe
//
//  Created by V on 10/17/15.
//  Copyright © 2015 hackathon. All rights reserved.
//

import UIKit

class AddCommentViewController: UIViewController {
    
    var inputField : UITextView = UITextView()
    let objId:String
    var commArr:[String]
    
    init(objectid: String, commentArray: [String]){
        self.objId = objectid
        self.commArr = commentArray
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        self.inputField = UITextView(frame: CGRectMake(15, 100, self.view.frame.size.width - (2 * 15), self.view.frame.size.height * 0.7))
        
        let addButton = UIButton(type: UIButtonType.System)
        addButton.frame = CGRectMake(self.view.frame.size.width * 0.62, self.view.frame.size.height * 0.85, 100, 60)
        addButton.titleLabel?.textAlignment = NSTextAlignment.Center
        addButton.setTitle("Done", forState: UIControlState.Normal)
        addButton.addTarget(self, action: "addComment", forControlEvents: UIControlEvents.TouchUpInside)
        addButton.layer.zPosition = 100
        
        let cancelButton = UIButton(type: UIButtonType.System)
        cancelButton.frame = CGRectMake(self.view.frame.size.width * 0.1, self.view.frame.size.height * 0.85, 100, 60)
        cancelButton.titleLabel?.textAlignment = NSTextAlignment.Center
        cancelButton.setTitle("Cancel", forState: UIControlState.Normal)
        cancelButton.addTarget(self, action: "goBack", forControlEvents: UIControlEvents.TouchUpInside)
        cancelButton.layer.zPosition = 100
        
        self.view.addSubview(inputField)
        self.view.addSubview(addButton)
        self.view.addSubview(cancelButton)
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func addComment() {
        
        let query = PFQuery(className:"Post")
        query.getObjectInBackgroundWithId(self.objId) {
            (gameScore: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let gameScore = gameScore {
                self.commArr.append(self.inputField.text)
                gameScore.setObject(self.commArr, forKey: "comments")
                gameScore.saveInBackground()
            }
        }
        
        
        
        self.goBack()
    }
    
    func goBack() {
        self.dismissViewControllerAnimated(true, completion: nil)
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
