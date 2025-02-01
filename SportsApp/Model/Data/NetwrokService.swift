//
//  NetwrokService.swift
//  SportsApp
//
//  Created by Andrew Emad on 01/02/2025.
//

import Foundation

class NetworkService {
    static func fetchDataFromJSONLeauge(sport:Int ,completionHandler : @escaping (LeaugeList?)->Void){
        var temp :String
        switch sport{
        case 0:
            temp="football"
        case 1:
            temp="basketball"
        case 2:
            temp="cricket"
        case 3:
            temp="tennis"
        default:
            temp=""
        }
        let url = URL(string: "https://apiv2.allsportsapi.com/\(temp)?met=Leagues&APIkey=2d81e4425a40005f3d1153e7144b2dffb6f3a9af4bb958819e938c69bd524dd6")
        guard let newUrl = url else{return}
        let request = URLRequest(url: newUrl)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else{return}
            do{
                let result = try JSONDecoder().decode(LeaugeList.self, from: data)
                completionHandler(result)
            }catch{
                print(error)
                completionHandler(nil)
            }
            
        }
        task.resume()
    }
    static func fetchDataFromJSONLeaugeDetails(sport:Int ,completionHandler : @escaping (LeaugeList?)->Void){
       
        let url = URL(string: "https://apiv2.allsportsapi.com/football/?met=Fixtures&APIkey=2d81e4425a40005f3d1153e7144b2dffb6f3a9af4bb958819e938c69bd524dd6&from=2021-05-18&to=2021-05-18")
        guard let newUrl = url else{return}
        let request = URLRequest(url: newUrl)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else{return}
            do{
                let result = try JSONDecoder().decode(LeaugeList.self, from: data)
                completionHandler(result)
            }catch{
                print(error)
                completionHandler(nil)
            }
            
        }
        task.resume()
    }
}
