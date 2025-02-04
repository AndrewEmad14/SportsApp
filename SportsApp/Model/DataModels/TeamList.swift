//
//  TeamList.swift
//  SportsApp
//
//  Created by Andrew Emad on 03/02/2025.
//

import Foundation

class TeamList :Decodable{
    var result:[Team]?
    var success:Int?
    
}
class Team : Decodable{
    var team_name: String?
    var team_logo: String?
    var players : [Player]?
}
class Player:Decodable {
    var player_image: String?
    var player_name: String?
    var player_number: String?
}
