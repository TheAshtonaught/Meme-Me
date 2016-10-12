//
//  CollectionVC.swift
//  memev1
//
//  Created by Ashton Morgan on 10/6/16.
//  Copyright © 2016 algebet. All rights reserved.
//

import UIKit

private let reuseIdentifier = "memeCollectionViewCell"


class CollectionVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var memes: [Meme]!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewWillAppear(animated: Bool) {
        tabBarController?.tabBar.hidden = false
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
        
        self.collectionView?.reloadData()
    }

    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return memes.count
    }
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0

        return CGSize(width: collectionView.frame.width/3.025, height: collectionView.frame.width/4.1)
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MemeCollectionViewCell
        let meme = memes[indexPath.item]
        cell.memeImg.image = meme.memedImage
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let memeView = self.storyboard?.instantiateViewControllerWithIdentifier("DetailMemeVC") as! DetailMemeVC
        memeView.meme = self.memes[indexPath.item]
        self.navigationController?.pushViewController(memeView, animated: true)
    }

}
