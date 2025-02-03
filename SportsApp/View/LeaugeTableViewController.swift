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
    var leaugeList : LeaugeList?
    var sport:Int?
    let reachability = try! Reachability()
    func retrieveFromInternet(res: DataModel) {
        DispatchQueue.main.async {
            self.leaugeList = res as? LeaugeList
            self.tableView.reloadData()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "LeaugeTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "cell")
        let present = Present()
        present.retriveFromInternet=self
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                present.getDataFromNetwork(urlString: URLEnums.FootBallLeauge.rawValue)
            }
        }
        reachability.whenUnreachable = { _ in
            let alert = UIAlertController(title: "Alert", message: "Sorry, we couldnt load this page", preferredStyle: UIAlertController.Style.alert)
            let alertAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }

       
       
   
    }



    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        guard let temp = leaugeList?.result.count else{ return 0}
        return temp
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeaugeTableViewCell
        guard let temp = leaugeList?.result[indexPath.row].league_logo else { return cell }
        
        cell.imageCell.sd_setImage(with: URL(string: temp), placeholderImage: UIImage(named: "Football"))
        cell.imageCell.layer.cornerRadius = 40
        cell.labelCell.text=leaugeList?.result[indexPath.row].league_name
       
     
    

        return cell
    }
    //LeaugeDetailsView
    override func tableView(_ tableView: UITableView, performPrimaryActionForRowAt indexPath: IndexPath) {
        let view = self.storyboard?.instantiateViewController(withIdentifier: "LeaugeDetailsView") as! LeaugeDetailsCollectionViewController
        
        if let tempLogo = leaugeList?.result[indexPath.row].league_logo{
            view.currentLeauge.logo=tempLogo
        }else{
            view.currentLeauge.logo=""
        }
        
        guard let tempName = leaugeList?.result[indexPath.row].league_name else {return}
        guard let tempKey = leaugeList?.result[indexPath.row].league_key else {return}
        view.currentLeauge.name = tempName
        view.currentLeauge.id = Int64(tempKey)
        self.navigationController?.pushViewController(view, animated: true)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


  

}
