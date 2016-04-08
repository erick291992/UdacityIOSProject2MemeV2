//
//  SentMemesViewController.swift
//  MemeMe
//
//  Created by Erick Manrique on 4/7/16.
//  Copyright © 2016 appsathome. All rights reserved.
//

import UIKit

class SentMemesViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var image:UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setup(){
        self.imageView.image = image
        self.tabBarController?.tabBar.hidden = true
    }

}
