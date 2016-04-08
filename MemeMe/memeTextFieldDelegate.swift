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
        //where do i get topTextField and bottomTextField
        //they are only in the MemeEditorViewController unless i need to make the outlet in this class
        /*
        if textField == topTextField || textField == bottomTextField {
            textField.text = ""
        }
         */
        
        if textField.text == "TOP" || textField.text == "BOTTOM"{
            textField.text = ""
        }
    }
}