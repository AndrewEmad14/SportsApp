//
//  LeaugeDetailsCollectionViewController.swift
//  SportsApp
//
//  Created by Andrew Emad on 02/02/2025.
//

import UIKit
import Reachability

private let reuseIdentifier = "Cell"

class LeaugeDetailsCollectionViewController: UICollectionViewController ,CoreDataAdd  {

    func AddToCoreData(data: Leauge) {
        present.addDataToCoreData(data: data)
    }
    var currentLeauge = Leauge()
    var FavoriteButtonFlag=0
    let present = Present()
    var startDate="2021-05-18"
    var endDate = "2026-05-18"
    var connection:Bool = false
    func ConnectingToTheApi(){
        present.checkNetworkConnection()
        present.bindResultToViewController = { () in
            self.connection = self.present.presenterConnectionFlag!
            if self.connection {
                var tempStr = URLEnums.FootBallLeaugeDetails.rawValue + "&leagueId= \(self.currentLeauge.league_key!)" + URLEnums.LeagueDetailsAPIKey.rawValue + "&from=\(self.startDate)&to=\(self.endDate)"
                self.present.getDataFromNetwork(urlString:  tempStr)
            }else{
                let alert = UIAlertController(title: "Alert", message: "Sorry, we couldnt load this page", preferredStyle: UIAlertController.Style.alert)
                let alertAction = UIAlertAction(title: "OK", style: .default) { action in
                    self.navigationController?.popViewController(animated: true)
                }
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
                
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let favButton = UIBarButtonItem(image: UIImage(named: "heart"), style: .plain, target: self, action: #selector(FavoriteButtonClick))
        self.navigationItem.rightBarButtonItem=favButton
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        present.cdAdd=self
       // present.retriveFromInternet=self
        
        
        
    }
    @objc func FavoriteButtonClick(){
        if FavoriteButtonFlag == 0 {
            self.navigationItem.rightBarButtonItem?.image=UIImage(named: "heartFill")
            FavoriteButtonFlag=1
            AddToCoreData(data: currentLeauge)
        }else{
            self.navigationItem.rightBarButtonItem?.image=UIImage(named: "heart")
            FavoriteButtonFlag=0
           
            
        }
    }
 
   

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
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

    

}
