//
//  memeTableViewCell.swift
//  MemeMe
//
//  Created by Erick Manrique on 4/7/16.
//  Copyright © 2016 appsathome. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {

    @IBOutlet weak var memeImage: UIImageView!
    
    @IBOutlet weak var memeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(memeImage: UIImage, memeTopText:String, memeBottomText:String){
        self.memeImage.image = memeImage
        self.memeLabel.text = "\(memeTopText) \(memeBottomText)"
    }

}
