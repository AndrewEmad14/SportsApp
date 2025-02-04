//
//  LeaugeDetailsCollectionViewController.swift
//  SportsApp
//
//  Created by Andrew Emad on 02/02/2025.
//

import UIKit
import Reachability

private let reuseIdentifier = "Cell"

class LeaugeDetailsCollectionViewController: UICollectionViewController ,UICollectionViewDelegateFlowLayout,CoreDataAdd ,ViewInternetRetriveLeaugeDetailsProtocol {
    var currentLeauge = Leauge()
    var FavoriteButtonFlag=0
    let present = Present()
    var startDate="2024-12-01"
    var endDate = "2025-12-01"
    var connection:Bool = false
    var leaugeDetailsList : LeaugeDetailsList?
    func retrieveFromInternet(res: LeaugeDetailsList) {
        DispatchQueue.main.async {
            self.leaugeDetailsList = res
           
            self.collectionView.reloadData()
        }
    }
    func filterUpcomingMatches()->Int{
        guard let upcomingEvents = leaugeDetailsList?.result?.filter({$0.event_final_result == "-"}) else {return 0}
        return upcomingEvents.count
    }

    func AddToCoreData(data: Leauge) {
        present.addDataToCoreData(data: data)
    }

    
    func ConnectingToTheApi(){
        present.checkNetworkConnection()
        let tempStr = URLEnums.FootBallLeaugeDetails.rawValue + "&leagueId= \(self.currentLeauge.league_key!)" + URLEnums.LeagueDetailsAPIKey.rawValue + "&from=\(self.startDate)&to=\(self.endDate)"
        self.present.getDataFromNetworkLeaugeDetails(urlString:  tempStr)
        present.bindResultToViewController = { () in
            self.connection = self.present.presenterConnectionFlag!
            if self.connection {
             
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
        let nib = UINib(nibName: "LeaugeDetailsCollectionViewCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "collectionCell")
        let favButton = UIBarButtonItem(image: UIImage(named: "heart"), style: .plain, target: self, action: #selector(FavoriteButtonClick))
        self.navigationItem.rightBarButtonItem=favButton
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        present.cdAdd=self
        present.presenterLeaugeDetailsProtocol=self
        ConnectingToTheApi()
        
        
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
       
        return 2
    }
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return filterUpcomingMatches()
        }else{
            guard let temp = leaugeDetailsList?.result?.count else{return 0}
            return temp - filterUpcomingMatches()
        }
       
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! LeaugeDetailsCollectionViewCell
        cell.LeftTeam.text = leaugeDetailsList?.result?[indexPath.row].event_home_team
        cell.rightTeam.text = leaugeDetailsList?.result?[indexPath.row].event_home_team
        cell.date.text = leaugeDetailsList?.result?[indexPath.row].event_date
        cell.time.text =  leaugeDetailsList?.result?[indexPath.row].event_time
        guard let tempLeftStr = leaugeDetailsList?.result?[indexPath.row].home_team_logo else {return cell}
        guard let tempRightStr = leaugeDetailsList?.result?[indexPath.row].away_team_logo else {return cell}
        cell.leftImage.sd_setImage(with: URL(string: tempLeftStr), placeholderImage:UIImage(named: "Football") )
        cell.rightImage.sd_setImage(with: URL(string: tempRightStr), placeholderImage: UIImage(named: "Football"))
        
        // Configure the cell
    
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                           layout collectionViewLayout: UICollectionViewLayout,
                           sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row < filterUpcomingMatches(){
            return CGSize(width: 380, height: 230)
        }else{
            return CGSize(width: 380, height: 210)
        }
             // Fixed size for all cells
       }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectionHeader", for: indexPath) as! SectionCollectionReusableView
        if indexPath.row < filterUpcomingMatches(){
            headerView.sectionLabel.text = "Upcoming Matches"
        }else{
            headerView.sectionLabel.text = "Latest Events"
        }
       
       return headerView
    
    }
  
    

}
