//
//  URLEnums.swift
//  SportsApp
//
//  Created by Andrew Emad on 02/02/2025.
//

import Foundation

enum URLEnums:String{
    case FootBallLeauge = "https://apiv2.allsportsapi.com/football?met=Leagues&APIkey=2d81e4425a40005f3d1153e7144b2dffb6f3a9af4bb958819e938c69bd524dd6"
    case BasketBallLeauge = "https://apiv2.allsportsapi.com/basketball?met=Leagues&APIkey=2d81e4425a40005f3d1153e7144b2dffb6f3a9af4bb958819e938c69bd524dd6"
    case CricketLeauge = "https://apiv2.allsportsapi.com/cricket?met=Leagues&APIkey=2d81e4425a40005f3d1153e7144b2dffb6f3a9af4bb958819e938c69bd524dd6"
    case TennisLeauge = "https://apiv2.allsportsapi.com/tennis?met=Leagues&APIkey=2d81e4425a40005f3d1153e7144b2dffb6f3a9af4bb958819e938c69bd524dd6"
    case FootBallLeaugeDetails = "https://apiv2.allsportsapi.com/football/?met=Fixtures"
    case BasketBallLeaugeDetails = "https://apiv2.allsportsapi.com/basketball/?met=Fixtures"
    case CricketLeaugeDetails = "https://apiv2.allsportsapi.com/cricket/?met=Fixtures"
    case TennisLeaugeDetails = "https://apiv2.allsportsapi.com/tennis/?met=Fixtures"
    case LeagueDetailsAPIKey =  "&APIkey=2d81e4425a40005f3d1153e7144b2dffb6f3a9af4bb958819e938c69bd524dd6"
    case FootBallTeams = "https://apiv2.allsportsapi.com/football/?&met=Teams"
       
}
