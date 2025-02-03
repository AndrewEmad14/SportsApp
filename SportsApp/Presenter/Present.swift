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
    func getDataFromNetwork(urlString : String){
        NetworkService.fetchDataFromJSONLeauge(urlString: urlString) { res in
            guard let result = res else {print("watashiwa NIL desu");return}
            self.retriveFromInternet?.retrieveFromInternet(res: result)
        }
    }
    func getDataFromCoreData()->[CoreDataModel]?{
        
        guard let temp = CoreDataService.loadData() else {return nil}
        return temp
    }
    func addDataToCoreData(data : CoreDataModel){
        CoreDataService.saveData(data: data)

    }
    func removeDataFromCoreData(data : CoreDataModel){
        CoreDataService.removeData(data : data)
        
    }
}
