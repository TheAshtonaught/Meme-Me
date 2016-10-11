//
//  ViewController.swift
//  memev1
//
//  Created by Ashton Morgan on 9/28/16.
//  Copyright © 2016 algebet. All rights reserved.
//
import Foundation
import UIKit
import AVFoundation

class MemeEditorVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var navBar: UINavigationBar!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setUI()
        
        subscribeToKeyboardNotifications()
        pickerController.delegate = self
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textFieldLayout()
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated)
        unsubFromKeyboardNotifiacations()
    }

    @IBAction func pickAnImage(sender: AnyObject) {
        presentViewController(pickerController, animated: true, completion: nil)
    }
    @IBAction func cameraButtonPressed(sender: AnyObject) {
        if cameraButton.enabled {
            pickerController.sourceType = .Camera
            presentViewController(pickerController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imgView.image = pickedImage
            shareButton.enabled = true
        }
            dismissViewControllerAnimated(true, completion: nil)
    }
        
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    func setUI() {
        tabBarController?.tabBar.hidden = true
        hideBars(false)
        stylizeTextField(topTextField)
        stylizeTextField(bottomTextField)
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
    }
    
    func stylizeTextField(textField: UITextField) {
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = NSTextAlignment.Center
    }

    func textFieldLayout() {
        if topTextConstraint != nil {
            view.removeConstraint(topTextConstraint)
        }
        if bottomTextConstraint != nil {
            view.removeConstraint(bottomTextConstraint)
        }
        
        //Get the position of the image inside the imageView
        let size = imgView.image != nil ? imgView.image!.size : imgView.frame.size
        let frame = AVMakeRectWithAspectRatioInsideRect(size, imgView.bounds)
        
        //A margin for the new constrains; 10% of the frame's height
        let margin = frame.origin.y + frame.size.height * 0.09
        
        //Create and add the new constraints
        topTextConstraint = NSLayoutConstraint(
            item: topTextField,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: imgView,
            attribute: .Top,
            multiplier: 1.0,
            constant: margin)
        view.addConstraint(topTextConstraint)
        
        bottomTextConstraint = NSLayoutConstraint(
            item: bottomTextField,
            attribute: .Bottom,
            relatedBy: .Equal,
            toItem: imgView,
            attribute: .Bottom,
            multiplier: 1.0,
            constant: -margin)
        view.addConstraint(bottomTextConstraint)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
        textField.textAlignment = NSTextAlignment.Center
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func keyboardWillShow(notif: NSNotification) {
       if bottomTextField.isFirstResponder() {
    self.view.frame.origin.y = -getKeyboardHeight(notif)
        }
    }
    func keyboardWillHide(notif: NSNotification) {
       if bottomTextField.resignFirstResponder(){
            self.view.frame.origin.y = 0
            }
        }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeEditorVC.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeEditorVC.keyboardWillHide(_:)) , name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func getKeyboardHeight(notif: NSNotification) -> CGFloat {
        let userInfo = notif.userInfo
        let boardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return boardSize.CGRectValue().height
    }
    
    func unsubFromKeyboardNotifiacations() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        
    }
    func hideBars(hide: Bool) {
        toolbar.hidden = hide
        navBar.hidden = hide
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func generateMemedImage() -> UIImage
    {
        hideBars(true)
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame,
                                     afterScreenUpdates: true)
        memedImage =
            UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return memedImage
    }
    
    func save() {
        let meme = Meme(topText: topTextField.text, bottomText: bottomTextField.text, image: imgView.image, memedImage: memedImage)
        print(meme.bottomText)
        let object = UIApplication.sharedApplication().delegate
        let appdel = object as! AppDelegate
        appdel.memes.append(meme)
    }
    
    @IBAction func shareButtonPressed(sender: AnyObject) {
        generateMemedImage()
        let controller = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        self.presentViewController(controller, animated: true, completion: nil)
        
        controller.completionWithItemsHandler = { acitivity, success, items, error in
            if success {
               
                self.save()
                self.hideBars(false)
                let collectionVC = self.storyboard!.instantiateViewControllerWithIdentifier("collectionVC")
                self.navigationController?.pushViewController(collectionVC, animated: true)
                
                print("you have successfully saved a meme")
            }else {
                print(error.debugDescription)
            }
        }
    }

}