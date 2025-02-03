//
//  presenter.swift
//  SportsApp
//
//  Created by Andrew Emad on 01/02/2025.
//

import Foundation
class Present{
    var retriveFromInternet : ViewInternetRetriveProtocol?
    var cdLoad: CoreDataLoad?
    var cdAdd : CoreDataAdd?
    var cdRemove: CoreDataRemove?
    var bindResultToViewController : (()->()) = {}
    var presenterConnectionFlag : Bool?{
        didSet{
            bindResultToViewController()
        }
    }
    func getDataFromNetwork(urlString : String){
        
        NetworkService.sharedInstance.fetchDataFromJSONLeauge(urlString: urlString) { res in
            guard let result = res else {print("watashiwa NIL desu");return}
            self.retriveFromInternet?.retrieveFromInternet(res: result)
        }
    }
    func checkNetworkConnection(){
        NetworkService.sharedInstance.stopMonitor()
        NetworkService.sharedInstance.startMonitor()
        NetworkService.sharedInstance.checkConnection { connection in
            self.presenterConnectionFlag=connection
        }
      
       
    }
    func getDataFromCoreData()->[Leauge]?{
        
        guard let temp = CoreDataService.loadData() else {return nil}
        return temp
    }
    func addDataToCoreData(data : Leauge){
        CoreDataService.saveData(data: data)

    }
    func removeDataFromCoreData(data : Leauge){
        CoreDataService.removeData(data : data)
    }
}
