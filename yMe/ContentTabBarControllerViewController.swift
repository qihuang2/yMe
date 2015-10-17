//
//  ContentTabBarControllerViewController.swift
//  yMe
//
//  Created by Qi Feng Huang on 10/16/15.
//  Copyright © 2015 hackathon. All rights reserved.
//

import UIKit

class ContentTabBarControllerViewController: UITabBarController{

    init(arrControllers : [UIViewController]){
        super.init(nibName: nil, bundle: nil)
        
        let view1 = arrControllers[0]
        let view2 = arrControllers[1]
        
        view1.tabBarItem = UITabBarItem(title: "First", image: nil, tag: 0)
        view2.tabBarItem = UITabBarItem(title: "Second", image: nil, tag: 0)
        
        self.viewControllers = [view1, view2]
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
