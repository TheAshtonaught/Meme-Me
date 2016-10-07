//
//  CollectionVC.swift
//  memev1
//
//  Created by Ashton Morgan on 10/6/16.
//  Copyright © 2016 algebet. All rights reserved.
//

import UIKit

private let reuseIdentifier = "memeCollectionViewCell"


class CollectionVC: UICollectionViewController {
    
    var memes: [Meme]!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Register cell classes
        // self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }
    override func viewWillAppear(animated: Bool) {
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
        
        self.collectionView?.reloadData()
    }

    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return memes.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MemeCollectionViewCell
        let meme = memes[indexPath.item]
        
        
        cell.memeImg.image = meme.image
        cell.topTextField.text = meme.topText
        cell.bottomTextField.text = meme.bottomText
        
        stylizeTextField(cell.bottomTextField)
        stylizeTextField(cell.topTextField)
    
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        print("item selected")
    }
    
    func stylizeTextField(textField: UITextField) {
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = NSTextAlignment.Center
    }

}
