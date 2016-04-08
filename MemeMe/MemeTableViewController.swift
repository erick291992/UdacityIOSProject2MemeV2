//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Erick Manrique on 4/7/16.
//  Copyright © 2016 appsathome. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Global Variables
    var memes:[Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }

    //MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewDidAppear(animated: Bool) {
        hideTabBar(false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return memes.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier(IDENTIFIER_CELL_TABLE_MEME) as? MemeTableViewCell {
            let meme = memes[indexPath.row]
            cell.configureCell(meme.memeImage!, memeTopText: meme.topText!, memeBottomText: meme.bottomText!)
            return cell
        }
        else{
            return MemeTableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailViewController = self.storyboard?.instantiateViewControllerWithIdentifier(IDENTIFIER_VC_SENT_MEMES) as! SentMemesViewController
        detailViewController.image = memes[indexPath.row].memeImage!
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }

    func hideTabBar(hide:Bool){
        self.tabBarController?.tabBar.hidden = hide
    }

}
