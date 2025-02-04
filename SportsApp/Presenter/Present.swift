//
//  presenter.swift
//  SportsApp
//
//  Created by Andrew Emad on 01/02/2025.
//

import Foundation
class Present{
    var presenterLeaugeProtocol : ViewInternetRetriveLeaugeProtocol?
    var presenterLeaugeDetailsProtocol : ViewInternetRetriveLeaugeDetailsProtocol?
    var cdLoad: CoreDataLoad?
    var cdAdd : CoreDataAdd?
    var cdRemove: CoreDataRemove?
    var bindResultToViewController : (()->()) = {}
    var presenterConnectionFlag : Bool?{
        didSet{
            bindResultToViewController()
        }
    }
    func getDataFromNetworkLeauge(urlString : String){
        
        NetworkService.sharedInstance.fetchDataFromJSONLeauge(urlString: urlString) { res in
            guard let result = res else {print("watashiwa NIL desu");return}
            self.presenterLeaugeProtocol?.retrieveFromInternet(res: result)
        }
    }
    func getDataFromNetworkLeaugeDetails(urlString : String){
        
        NetworkService.sharedInstance.fetchDataFromJSONLeaugeDetails(urlString: urlString) { res in
            guard let result = res else {print("watashiwa NIL desu");return}
            self.presenterLeaugeDetailsProtocol?.retrieveFromInternet(res: result)
        }
    }
    func getDataFromNetworkTeamDetails(urlString:String){
        NetworkService.sharedInstance.fetchDataFromJSONTeam(urlString: urlString) { res in
            guard let result = res else {print("watashiwa NIL desu");return}
            self.presenterLeaugeDetailsProtocol?.retrieveFromInternetTeam(res: result)
        }
    }
    func checkNetworkConnection(){
     
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
