//
//  protocols.swift
//  SportsApp
//
//  Created by Andrew Emad on 01/02/2025.
//

import Foundation

protocol ViewInternetRetriveLeaugeProtocol{
    func retrieveFromInternet(res: LeaugeList)
 
}
protocol ViewInternetRetriveLeaugeDetailsProtocol{
    func retrieveFromInternet(res: LeaugeDetailsList)
    func retrieveFromInternetTeam(res: TeamList)
}
protocol CoreDataLoad{
    func loadFromCoreData()
}
protocol CoreDataAdd{
    func AddToCoreData(data: Leauge)
}
protocol CoreDataRemove{
    func removeFromCoreData(data: Leauge)
}


