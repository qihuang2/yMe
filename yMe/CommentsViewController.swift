//
//  CommentsViewController.swift
//  yMe
//
//  Created by V on 10/16/15.
//  Copyright © 2015 hackathon. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    let comments : [String]
    let tableView = UITableView()
    let objId:String
    
    init(comments : [String], objectId: String) {
        self.comments = comments
        self.objId = objectId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("CommentsViewController loaded")
        
        tableView.frame         =  CGRect(origin: CGPointZero, size: self.view.frame.size)
        tableView.delegate      =   self
        tableView.dataSource    =   self
        tableView.rowHeight = 70
        
        tableView.separatorStyle = .SingleLineEtched
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.view.addSubview(tableView)
        
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.comments.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        cell.textLabel?.text = self.comments[indexPath.row]
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
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
