//
//  LeaugeListDetails.swift
//  SportsApp
//
//  Created by Andrew Emad on 02/02/2025.
//

import Foundation
struct LeaugeDetailsList : Decodable{
    var result : [LeaugeDetails]?
}
struct LeaugeDetails : Decodable{
    var event_date: String?
    var event_time: String?
    var event_home_team: String?
    var event_away_team: String?
    var event_final_result : String?
    var home_team_logo : String?
    var away_team_logo : String?
}
