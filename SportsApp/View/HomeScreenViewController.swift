//
//  ViewController.swift
//  SportsApp
//
//  Created by Andrew Emad on 30/01/2025.
//

import UIKit
class HomeScreenViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    let numberOfSections = 1
    let numberOfRows = 4
   
    @IBOutlet weak var collectionView: UICollectionView!
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSections
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let   cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeScreenCollectionViewCell
        cell.homeCellImage.image=UIImage(named: "2")
        cell.homeCellLabel.text="FooootBall"
        return cell
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        collectionView.dataSource=self
        collectionView.delegate=self
      
        // Do any additional setup after loading the view.
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
        return CGSize(width: view.frame.size.width/3, height: view.frame.size.width/3)
    }
  
}

