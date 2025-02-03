//
//  Leauges.swift
//  SportsApp
//
//  Created by Andrew Emad on 01/02/2025.
//

import Foundation


class LeaugeList :Decodable{
    var result:[Leauge]?
    var success:Int?
    
}

class Leauge :Decodable {
    var league_key : Int?
    var league_name : String?
    var league_logo : String?
}
