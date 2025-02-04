//
//  LeaugeDetailsCollectionViewController.swift
//  SportsApp
//
//  Created by Andrew Emad on 02/02/2025.
//

import UIKit
import Reachability

private let reuseIdentifier = "Cell"

class LeaugeDetailsCollectionViewController: UICollectionViewController ,CoreDataAdd ,ViewInternetRetriveLeaugeDetailsProtocol {

    
    var currentLeauge = Leauge()
    var FavoriteButtonFlag=0
    let present = Present()
    var startDate="2024-01-01"
    var endDate = "2026-12-01"
    var connection:Bool = false
    var leaugeDetailsList : LeaugeDetailsList?
    var upcomingMatches : [LeaugeDetails]?
    var latestEvents: [LeaugeDetails]?
    var teamList: TeamList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib1 = UINib(nibName: "LeaugeDetailsCollectionViewCell", bundle: nil)
        self.collectionView.register(nib1, forCellWithReuseIdentifier: "collectionCell")
        let nib2 = UINib(nibName: "LatestEventsCell", bundle: nil)
        self.collectionView.register(nib2, forCellWithReuseIdentifier: "latestEventsCell")
        let nib3 = UINib(nibName: "teamCells", bundle: nil)
        self.collectionView.register(nib3, forCellWithReuseIdentifier: "teamCells")
        let favButton = UIBarButtonItem(image: UIImage(named: "heart"), style: .plain, target: self, action: #selector(FavoriteButtonClick))
        self.navigationItem.rightBarButtonItem=favButton
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        
        present.cdAdd=self
        present.presenterLeaugeDetailsProtocol=self
        ConnectingToTheApi()
       
       
        filterLatestEvents()
        createLayout()
        
        
        
    }
    func createLayout(){
        let layout = UICollectionViewCompositionalLayout{ index,enviroment in
            switch index{
            case 0:
                return self.drawTopSection()
            case 1:
                return  self.drawMiddleSection()
            case 2:
                return self.drawBottomSection()
            default:
                return nil
            }
        
            
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
        
    }
    func drawTopSection() ->NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
         , heightDimension: .fractionalHeight(1))
         let item = NSCollectionLayoutItem(layoutSize: itemSize)
         
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(380)
        , heightDimension: .absolute(230))
         let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize
         , subitems: [item])
             group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
             , bottom: 0, trailing: 15)
             
         let section = NSCollectionLayoutSection(group: group)
             section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15
             , bottom: 10, trailing: 0)
    
        section.orthogonalScrollingBehavior = .continuous
             
            return section
    }
    
    
 
    
    func drawMiddleSection() ->NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0)
              , heightDimension: .fractionalHeight(1))
              let item = NSCollectionLayoutItem(layoutSize: itemSize)
              
              let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(380)
              , heightDimension: .absolute(210))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
              group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0
              , bottom: 10, trailing: 15)
              
              let section = NSCollectionLayoutSection(group: group)
              section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15
              , bottom: 10, trailing: 0)
    
              
              return section
    }
    
    func drawBottomSection() ->NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
                                              , heightDimension: .fractionalHeight(1))
         let item = NSCollectionLayoutItem(layoutSize: itemSize)
         
         let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(205)
         , heightDimension: .absolute(205))
         let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize
         , subitems: [item])
         group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
             , bottom: 0, trailing: 15)
             
         let section = NSCollectionLayoutSection(group: group)
             section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15
             , bottom: 10, trailing: 0)
    
        section.orthogonalScrollingBehavior = .groupPaging
             
            return section
    }
   
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
       
        return 3
    }
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        switch section{
        case 0 :
            filterUpcomingMatches()
            guard let temp = upcomingMatches?.count else {return 0}
            return temp
        case 1 :
            filterLatestEvents()
            guard let temp = latestEvents?.count else {return 0}
            return temp
        case 2 :
            guard let temp = teamList?.result?.count else {return 0}
            return temp
           
        default:
            return 0
    
        }
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section{
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! LeaugeDetailsCollectionViewCell
            cell.LeftTeam.text = upcomingMatches?[indexPath.row].event_home_team
            cell.rightTeam.text = upcomingMatches?[indexPath.row].event_home_team
            cell.date.text = upcomingMatches?[indexPath.row].event_date
            cell.time.text =  upcomingMatches?[indexPath.row].event_time
            guard let tempLeftStr = upcomingMatches?[indexPath.row].home_team_logo else {return cell}
            guard let tempRightStr = upcomingMatches?[indexPath.row].away_team_logo else {return cell}
            cell.leftImage.sd_setImage(with: URL(string: tempLeftStr), placeholderImage:UIImage(named: "Football") )
            cell.rightImage.sd_setImage(with: URL(string: tempRightStr), placeholderImage: UIImage(named: "Football"))
            return cell
        case 1:
	            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "latestEventsCell", for: indexPath) as! LatestEventsCell
            cell.leftTeamLabel.text = latestEvents?[indexPath.row].event_home_team
            cell.rightTeamLabel.text = latestEvents?[indexPath.row].event_away_team
            cell.dateLabel.text = latestEvents?[indexPath.row].event_date
            cell.timeLabel.text = latestEvents?[indexPath.row].event_time
            cell.score.text = latestEvents?[indexPath.row].event_final_result
            guard let tempLeftStr = latestEvents?[indexPath.row].home_team_logo else {return cell}
            guard let tempRightStr = latestEvents?[indexPath.row].away_team_logo else {return cell}
            cell.LeftTeamImg.sd_setImage(with: URL(string: tempLeftStr), placeholderImage: UIImage(named: "Football"))
            cell.rightTeamImg.sd_setImage(with: URL(string: tempRightStr), placeholderImage: UIImage(named: "Football"))
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCells", for: indexPath) as! teamCells
            guard let temp = teamList?.result?[indexPath.row].team_logo else {return cell}
            cell.teamImg.sd_setImage(with: URL(string: temp), placeholderImage: UIImage(named: "Football"))
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! LeaugeDetailsCollectionViewCell
            return cell
        }
 
       
    
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectionHeader", for: indexPath) as! SectionCollectionReusableView
        headerView.sectionLabel.text = "Upcoming Matches"
       
       return headerView
    
    }
    
    
    
    func retrieveFromInternet(res: LeaugeDetailsList) {
        DispatchQueue.main.async {
            self.leaugeDetailsList = res
          
            self.collectionView.reloadData()
        }
    }
    func retrieveFromInternetTeam(res: TeamList) {
        DispatchQueue.main.async {
            self.teamList = res
            self.collectionView.reloadData()
        }
    }
    func filterUpcomingMatches(){
      
        guard let temp = leaugeDetailsList?.result?.filter({$0.event_final_result == "-"}) else {return }
        
        upcomingMatches=temp
    }
    func filterLatestEvents(){
        guard let temp = leaugeDetailsList?.result?.filter({$0.event_final_result != "-"}) else {return}
        latestEvents=temp
    }
    
    func AddToCoreData(data: Leauge) {
        present.addDataToCoreData(data: data)
    }

    
    func ConnectingToTheApi(){
        present.checkNetworkConnection()
        let tempStr = URLEnums.FootBallLeaugeDetails.rawValue + "&leagueId= \(self.currentLeauge.league_key!)" + URLEnums.LeagueDetailsAPIKey.rawValue + "&from=\(self.startDate)&to=\(self.endDate)"
       
        self.present.getDataFromNetworkLeaugeDetails(urlString:  tempStr)
        
        let tempTeams = URLEnums.FootBallTeams.rawValue + "&leagueId= \(self.currentLeauge.league_key!)" + URLEnums.LeagueDetailsAPIKey.rawValue
        print (tempTeams)
        self.present.getDataFromNetworkTeamDetails(urlString: tempTeams)
        
        
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
 
   

  
    // 380 230
    
  
    

}
