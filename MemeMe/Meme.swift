//
//  Meme.swift
//  MemeMe
//
//  Created by Erick Manrique on 3/30/16.
//  Copyright © 2016 appsathome. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    
    var topText:String?
    var bottomText:String?
    var image:UIImage?
    var memeImage:UIImage?
    
    init(topText:String?, bottomText:String?, image:UIImage?, memeImage:UIImage?){
        self.topText = topText
        self.bottomText = bottomText
        self.image = image
        self.memeImage = memeImage
    }
    
    
}