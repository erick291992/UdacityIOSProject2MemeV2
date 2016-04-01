//
//  memeTextFieldDelegate.swift
//  MemeMe
//
//  Created by Erick Manrique on 4/1/16.
//  Copyright © 2016 appsathome. All rights reserved.
//

import Foundation
import UIKit

class memeTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM"{
            textField.text = ""
        }
    }
}