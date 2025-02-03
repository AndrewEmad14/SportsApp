//
//  protocols.swift
//  SportsApp
//
//  Created by Andrew Emad on 01/02/2025.
//

import Foundation

protocol ViewInternetRetriveProtocol{
    func retrieveFromInternet(res: DataModel)
}
protocol CoreDataLoad{
    func loadFromCoreData()
}
protocol CoreDataAdd{
    func AddToCoreData(data: CoreDataModel)
}
protocol CoreDataRemove{
    func removeFromCoreData(data: CoreDataModel)
}


