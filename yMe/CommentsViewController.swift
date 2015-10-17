//
//  CommentsViewController.swift
//  yMe
//
//  Created by V on 10/16/15.
//  Copyright © 2015 hackathon. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController {
    
    let comments : [String]
    
    init(comments : [String]) {
        self.comments = comments
        super.init(nibName: nil, bundle: nil)
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("CommentsViewController loaded")
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
