//
//  Leauges.swift
//  SportsApp
//
//  Created by Andrew Emad on 01/02/2025.
//

import Foundation


struct LeaugeList :Decodable{
    var result:[Leauge]
    var success:Int
    
}

struct Leauge :Decodable{
    var league_key : Int
    var league_name : String
    var country_key : Int
    var country_name : String
    var league_logo : String?
    var country_logo: String?
}
