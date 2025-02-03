//
//  FootBallLeaugeTableViewController.swift
//  SportsApp
//
//  Created by Andrew Emad on 31/01/2025.
//

import UIKit
import SDWebImage
import Reachability
class LeaugeTableViewController: UITableViewController ,ViewInternetRetriveProtocol {
   
    private let present = Present()
    var leaugeList : LeaugeList?
    var sport:Int?
    var connection:Bool = false
   
    func retrieveFromInternet(res: LeaugeList) {
        DispatchQueue.main.async {
            self.leaugeList = res 
            self.tableView.reloadData()
        }
    }
    
    func ConnectingToTheApi(){
        present.checkNetworkConnection()
        present.bindResultToViewController = { () in
            self.connection = self.present.presenterConnectionFlag!
            if self.connection {
                self.present.getDataFromNetwork(urlString: URLEnums.FootBallLeauge.rawValue)
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
        let nib = UINib(nibName: "LeaugeTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "cell")
        print("man i am dead")
        present.retriveFromInternet=self
        ConnectingToTheApi()
   
    }



    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        guard let temp = leaugeList?.result?.count else{ return 0}
        return temp
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeaugeTableViewCell
        guard let temp = leaugeList?.result?[indexPath.row].league_logo else { return cell }
        
        cell.imageCell.sd_setImage(with: URL(string: temp), placeholderImage: UIImage(named: "Football"))
        cell.imageCell.layer.cornerRadius = 40
        cell.labelCell.text=leaugeList?.result?[indexPath.row].league_name
       
     
    

        return cell
    }
    //LeaugeDetailsView
    override func tableView(_ tableView: UITableView, performPrimaryActionForRowAt indexPath: IndexPath) {
        let view = self.storyboard?.instantiateViewController(withIdentifier: "LeaugeDetailsView") as! LeaugeDetailsCollectionViewController
        
        if let tempLogo = leaugeList?.result?[indexPath.row].league_logo{
            view.currentLeauge.league_logo=tempLogo
        }else{
            view.currentLeauge.league_logo=""
        }
        
        guard let tempName = leaugeList?.result?[indexPath.row].league_name else {return}
        guard let tempKey = leaugeList?.result?[indexPath.row].league_key else {return}
        view.currentLeauge.league_name = tempName
        view.currentLeauge.league_key = tempKey
        self.navigationController?.pushViewController(view, animated: true)
    }
   

}
