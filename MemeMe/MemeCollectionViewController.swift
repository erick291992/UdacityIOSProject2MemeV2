//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Erick Manrique on 4/8/16.
//  Copyright © 2016 appsathome. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {

    // MARK: - Outlets
    @IBOutlet weak var flowLayout:UICollectionViewFlowLayout!
    
    @IBOutlet weak var memeCollectionView: UICollectionView!
    
    // MARK: - Global Variables
    var memes:[Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adjustCellToOrientation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        adjustCellToOrientation()
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        hideTabBar(false)
        self.memeCollectionView.reloadData()
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return memes.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(IDENTIFIER_CELL_COLLECTION_MEME, forIndexPath: indexPath) as! MemeCollectionViewCell
        let meme = memes[indexPath.row]
        cell.memeImage.image = meme.memeImage
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let detailViewController = self.storyboard?.instantiateViewControllerWithIdentifier(IDENTIFIER_VC_DETAIL_MEME) as! MemeDetailViewController
        detailViewController.imageView.image = memes[indexPath.row].memeImage
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    // MARK: Functions
    //http://stackoverflow.com/questions/25666269/ios8-swift-how-to-detect-orientation-change
    func adjustCellToOrientation(){
        let space :CGFloat = 3.0
        let height = self.view.frame.size.height
        let width = self.view.frame.size.width
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        let dimension:CGFloat!
        
        if UIDevice.currentDevice().orientation.isLandscape {
            let height = self.view.frame.size.height
            let width = self.view.frame.size.width
            dimension = (max(height,width) - (4*space))/5.0
        } else {
            dimension = (min(height,width) - (2*space))/3.0
        }
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
    }
    
    func hideTabBar(hide:Bool){
        self.tabBarController?.tabBar.hidden = hide
    }

}
