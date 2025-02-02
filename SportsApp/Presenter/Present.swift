//
//  presenter.swift
//  SportsApp
//
//  Created by Andrew Emad on 01/02/2025.
//

import Foundation
class Present{
    var view : ViewInternetRetriveProtocol?
    func getDataFromNetwork(urlString : String){
        NetworkService.fetchDataFromJSONLeauge(urlString: urlString) { res in
            guard let result = res else {print("watashiwa NIL desu");return}
            self.view?.retrieveFromInternet(res: result)
        }
    }
    func getDataFromCoreData(){
        CoreDataService.loadData()
    }
    func addDataToCoreDataBase(leaugeDetails : FootBallLeauge){
        CoreDataService.saveData(leaugeDetails: leaugeDetails)

    }
    func deleteDataFromCoreDataBase(index:Int){
        CoreDataService.deleteData(index: index)
        
    }
}
