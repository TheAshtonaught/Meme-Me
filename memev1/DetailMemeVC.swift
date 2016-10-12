//
//  DetailMemeVC.swift
//  memev1
//
//  Created by Ashton Morgan on 10/11/16.
//  Copyright © 2016 algebet. All rights reserved.
//

import UIKit

class DetailMemeVC: UIViewController {
    
    @IBOutlet weak var Edit: UIBarButtonItem!
    var meme: Meme!
    @IBOutlet weak var Imgview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.hidden = true
        Imgview.image = meme.memedImage
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setRightBarButtonItem(Edit, animated: true)
        

    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.hidden = false
    }


    @IBAction func editMeme(sender: AnyObject) {
        let memeEditorVC = self.storyboard?.instantiateViewControllerWithIdentifier("MemeEditorVC") as! MemeEditorVC
        memeEditorVC.memeSentFromDetail = self.meme
        self.navigationController?.pushViewController(memeEditorVC, animated: true)
    }
}
