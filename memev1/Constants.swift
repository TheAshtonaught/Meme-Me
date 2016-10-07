//
//  Constants.swift
//  memev1
//
//  Created by Ashton Morgan on 10/3/16.
//  Copyright © 2016 algebet. All rights reserved.
//

import Foundation
import UIKit

let memeTextAttributes = [
    NSStrokeColorAttributeName : UIColor.blackColor(),
    NSForegroundColorAttributeName : UIColor.whiteColor(),
    NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
    NSStrokeWidthAttributeName : -3.0
]

let pickerController = UIImagePickerController()

var memedImage: UIImage!
var topTextConstraint: NSLayoutConstraint!
var bottomTextConstraint: NSLayoutConstraint!

