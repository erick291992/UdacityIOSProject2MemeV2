//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Erick Manrique on 3/30/16.
//  Copyright © 2016 appsathome. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imagePickerView: UIImageView!

    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var navBar: UINavigationBar!
    
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        shareButton.enabled = false
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        
//        shareButton.enabled = false
        print("viewDidLoad")
       
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -5.0,
        ]
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        
        topTextField.textAlignment = NSTextAlignment.Center
        bottomTextField.textAlignment = NSTextAlignment.Center
        
        
    }

    override func viewWillAppear(animated: Bool) {
        print("viewWillAppear")
        super.viewWillAppear(animated)
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        self.subscribeToKeyboardNotifications()
        self.subscribeToHideKeyboardNotifications()
        
    }
    override func viewWillDisappear(animated: Bool) {
        print("viewWillDisappear")
        super.viewWillDisappear(animated)
        self.unsubscribeToKeyboardNotifications()
        self.unsubscribeToHideKeyboardNotifications()
    }
    
    
    

    @IBAction func pickAnImageFromAlbum(sender: AnyObject) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(pickerController, animated: true, completion: nil)
//        dismissViewControllerAnimated(true, completion: nil)
        //pickerController.dismissViewControllerAnimated(true, completion: nil)
    
    }
    
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(pickerController, animated: true, completion: nil)
    }
    
    //share image
    @IBAction func shareImage(sender: AnyObject) {
        let image = generateMemedImage()
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityController.completionWithItemsHandler = { activity, success, items, error in
            if success {
                
            }
        }
        self.presentViewController(activityController, animated: true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            shareButton.enabled = true
            imagePickerView.image = image
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        print("cancel")
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if(bottomTextField.editing && self.view.frame.origin.y == 0.0){
            self.view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    func keyboardWillHide(notification: NSNotification){
        if(bottomTextField.editing && self.view.frame.origin.y != 0.0){
            self.view.frame.origin.y = 0
        }
    }
    
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo!
        let keyboardSize = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    func subscribeToKeyboardNotifications() {
        //print("subscribeToKeyboardNotifications")
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
    }
    func unsubscribeToKeyboardNotifications() {
        //print("un-subscribeToKeyboardNotifications")
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func subscribeToHideKeyboardNotifications(){
        //print("subscribeToHideKeyboardNotifications")
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)

    }
    func unsubscribeToHideKeyboardNotifications(){
        //print("un-subscribeToHideKeyboardNotifications")
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)

    }
    
    func save() {
        //Create the meme
       let meme = Meme(topText:topTextField.text!, bottomText: bottomTextField.text, image: imagePickerView.image)
    }

    func generateMemedImage() -> UIImage {
        
        print("gen meme")
        // TODO: Hide toolbar and navbar
        toolbar.hidden = true
        navBar.hidden = true
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame,
                                     afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // TODO:  Show toolbar and navbar 
        toolbar.hidden = false
        navBar.hidden = false
        
        return memedImage
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    
}

