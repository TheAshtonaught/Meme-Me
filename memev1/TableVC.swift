//
//  TableVC.swift
//  memev1
//
//  Created by Ashton Morgan on 10/6/16.
//  Copyright © 2016 algebet. All rights reserved.
//

import UIKit

class TableVC: UITableViewController {

    var memes: [Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(animated: Bool) {
        tabBarController?.tabBar.hidden = false
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
        
        self.tableView.reloadData()
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return memes.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeTableViewCell", forIndexPath: indexPath) as! MemeTableViewCell
        let meme = memes[indexPath.row]
        cell.memeImg.image = meme.memedImage
        cell.memeLabel.text = "\(meme.topText)...\(meme.bottomText)"


        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let memeView = self.storyboard?.instantiateViewControllerWithIdentifier("MemeEditorVC") as! MemeEditorVC
        
        memeView.imgView.image = self.memes[indexPath.row].image
        memeView.topTextField.text = self.memes[indexPath.row].topText
        memeView.bottomTextField.text = self.memes[indexPath.row].bottomText
        
        self.navigationController?.pushViewController(memeView, animated: true)
    }

}
