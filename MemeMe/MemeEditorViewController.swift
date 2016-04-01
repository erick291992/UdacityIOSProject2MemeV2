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
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    let memeDelegate = memeTextFieldDelegate()
    //should be saved in internal memory
    var memes = [Meme]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //share button disabled in begining of app
        shareButton.enabled = false
        
        topTextField.delegate = memeDelegate
        bottomTextField.delegate = memeDelegate
        
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
       
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
    }
    override func viewWillDisappear(animated: Bool) {
        print("viewWillDisappear")
        super.viewWillDisappear(animated)
        self.unsubscribeToKeyboardNotifications()
    }
    
    //IBAtion functions

    @IBAction func pickAnImageFromAlbum(sender: AnyObject) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func shareImage(sender: AnyObject) {
        print("saved")
        let image = generateMemedImage()
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityController.completionWithItemsHandler = { activity, success, items, error in
            if error == nil {
                print("no error")
                if success{
                    self.save(image)
                    print("saved image")
                    activityController.dismissViewControllerAnimated(true, completion: nil)
                    self.shareButton.enabled = false
                    self.imagePickerView.image = nil
                }
            }
        }
        self.presentViewController(activityController, animated: true, completion: nil)
    }
    
    @IBAction func cancelImage(sender: AnyObject) {
        imagePickerView.image = nil
        shareButton.enabled = false
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        for value in memes{
            print("oooo")
            print(value.topText)
        }
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            shareButton.enabled = true
            imagePickerView.image = image
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //functions
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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    func unsubscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func save(memeImage:UIImage){
        //Create the meme
        let meme = Meme(topText:topTextField.text!, bottomText: bottomTextField.text, image: imagePickerView.image, memeImage: memeImage)
        self.memes.append(meme)
    }

    func generateMemedImage() -> UIImage {
        //Hide toolbar and navbar
        toolbar.hidden = true
        navBar.hidden = true
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame,
                                     afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //Show toolbar and navbar
        toolbar.hidden = false
        navBar.hidden = false
        
        return memedImage
    }
    
    //disable status bar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    //allow for touching ouside of textfield to dissmiss
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    
}

