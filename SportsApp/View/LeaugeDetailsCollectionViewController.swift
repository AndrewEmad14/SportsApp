//
//  LeaugeDetailsCollectionViewController.swift
//  SportsApp
//
//  Created by Andrew Emad on 02/02/2025.
//

import UIKit

private let reuseIdentifier = "Cell"

class LeaugeDetailsCollectionViewController: UICollectionViewController {
    
    // is there a way to use my football core
    var currentLeauge = FootBallCoreDataModel()
    var FavoriteButtonFlag=0
    let present = Present()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let favButton = UIBarButtonItem(image: UIImage(named: "heart"), style: .plain, target: self, action: #selector(FavoriteButtonClick))
        self.navigationItem.rightBarButtonItem=favButton
       
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        //present.view=self
  
    }
    @objc func FavoriteButtonClick(){
        if FavoriteButtonFlag == 0 {
            self.navigationItem.rightBarButtonItem?.image=UIImage(named: "heartFill")
            FavoriteButtonFlag=1
            addLeaugeToFavorites()
        }else{
            self.navigationItem.rightBarButtonItem?.image=UIImage(named: "heart")
            FavoriteButtonFlag=0
            removeLeaugeFromFavorites()
            
        }
    }
   func addLeaugeToFavorites(){
        
    }
    func removeLeaugeFromFavorites(){
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
