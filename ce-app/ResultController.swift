
//
//  ResultController.swift
//  ce-app
//
//  Created by Shannon Nachreiner on 2/21/16.
//  Copyright © 2016 delta. All rights reserved.
//

import UIKit

class ResultController: UICollectionViewController {
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
//    
//    let imageArr: [UIImage] = [UIImage(named: "full_breakfast")!, UIImage(named: "egg_benedict")!, UIImage(named: "hamburger")!, UIImage(named: "white_chocolate_donut")!, UIImage(named: "ChickenPestoSandwich")!]
//    let imageArr: [UIImage] = [UIImage(named: "ChickenPestoSandwich")!]
    
    var meteorClient: MeteorClient!
    var photoArr: [UIImage]!
    let expId = "mXnv5e4ZMsj5n9mi6"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        meteorClient = (UIApplication.sharedApplication().delegate as! AppDelegate).meteorClient
        photoArr = [UIImage]()
        
        setupDataSources()
    }
    
    func setupDataSources() {
        let params = [expId]
        meteorClient.callMethodName("getPhotos", parameters: params) { (response, error) -> Void in
            if let result = response {
                let base64Images: [String] = result["result"] as! [String]
                self.photoArr = base64Images.map({ (base64) -> UIImage in
                    let decodedData = NSData(base64EncodedString: base64, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
                    return UIImage(data: decodedData!)!
                })
                self.collectionView?.reloadData()
            }
        }
    }
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoArr.count
    }
    
    // make a cell for each cell index path
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ResultControllerCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
//        cell.resultImage.image = self.photoArr[indexPath.item]
        cell.resultImage.image = photoArr[indexPath.item]
        //cell.backgroundColor = UIColor.yellowColor() // make cell more visible in our example project
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
}
