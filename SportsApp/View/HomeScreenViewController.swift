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
    var imgList : [String]=[]
    @IBOutlet weak var collectionView: UICollectionView!
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfRows
    }
    // corner raduis needs changing also if we can enlarge the images abit
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let   cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeScreenCollectionViewCell
        cell.homeCellImage.image=UIImage(named: imgList[indexPath.row])
        cell.homeCellImage.clipsToBounds=false

        cell.homeCellImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner,.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        cell.homeCellImage.layer.masksToBounds=true
        cell.homeCellLabel.text=imgList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0:
            let view = self.storyboard?.instantiateViewController(withIdentifier: "LeaugeView") as! LeaugeTableViewController
            view.sport = 0
            self.navigationController?.pushViewController(view, animated: true)
            
        default:
            return
        }
    }
    
    func setLayout(){
        let layout = UICollectionViewFlowLayout()
      
        layout.itemSize=CGSize(width: view.frame.width/2-40, height:  view.frame.width/2-40)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = -20
        layout.sectionInset = UIEdgeInsets(top: 100, left: 40, bottom: 0, right: 40)
        collectionView.collectionViewLayout=layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource=self
        collectionView.delegate=self
        setLayout()
        self.navigationController?.navigationBar.tintColor = .white
        imgList.append("Football")
        imgList.append("Basketball")
        imgList.append("Cricket")
        imgList.append("Tennis")
        
      
    }

  
}
