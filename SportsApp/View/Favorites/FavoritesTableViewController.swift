//
//  FavoritesTableViewController.swift
//  SportsApp
//
//  Created by Andrew Emad on 02/02/2025.
//

import UIKit

class FavoritesTableViewController: UITableViewController , CoreDataLoad,CoreDataRemove{
  
    
    var coreDataList : [Leauge]=[]
    let present = Present()
    func loadFromCoreData() {
        guard let temp = present.getDataFromCoreData() else {return}
        coreDataList = temp
        tableView.reloadData()
    }
    
    func removeFromCoreData(data: Leauge) {
        present.removeDataFromCoreData(data: data)
    }
    override func viewDidAppear(_ animated: Bool) {
        loadFromCoreData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "LeaugeTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "cell")
        let present = Present()
        present.cdLoad=self
        present.cdRemove=self
        loadFromCoreData()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(coreDataList.count)
        return coreDataList.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeaugeTableViewCell
        guard let temp = coreDataList[indexPath.row].league_logo else { return cell }
        
        cell.imageCell.sd_setImage(with: URL(string: temp), placeholderImage: UIImage(named: "Football"))
        cell.imageCell.layer.cornerRadius = 40
        cell.labelCell.text=coreDataList[indexPath.row].league_name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            removeFromCoreData(data: coreDataList[indexPath.row])
            coreDataList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

}
