//
//  NetwrokService.swift
//  SportsApp
//
//  Created by Andrew Emad on 01/02/2025.
//

import Foundation
import Reachability
class NetworkService {
   
    private  let reachability = try! Reachability()
     static let sharedInstance = NetworkService()
    private init(){
        
    }
    func startMonitor(){
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
   
     func checkConnection(completionHandler : @escaping (_ connection:Bool?)->Void){
        
       
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("i am alive")
               completionHandler(true)
            }
        }
        reachability.whenUnreachable = { _ in
            print("i amnot alive")
            completionHandler(false)
        }
        
      

        
    }
      func fetchDataFromJSONLeauge(urlString : String ,completionHandler : @escaping (LeaugeList?)->Void){
       
        let url = URL(string: urlString)
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
    func fetchDataFromJSONLeaugeDetails(urlString : String ,completionHandler : @escaping (LeaugeDetailsList?)->Void){
     
      let url = URL(string: urlString)
      guard let newUrl = url else{return}
      let request = URLRequest(url: newUrl)
      let session = URLSession(configuration: .default)
      let task = session.dataTask(with: request) { data, response, error in
          guard let data = data else{return}
          do{
              let result = try JSONDecoder().decode(LeaugeDetailsList.self, from: data)
              completionHandler(result)
          }catch{
              print(error)
              completionHandler(nil)
          }
          
      }
      task.resume()
  }
    func fetchDataFromJSONTeam(urlString : String ,completionHandler : @escaping (TeamList?)->Void){
     
      let url = URL(string: urlString)
      guard let newUrl = url else{return}
      let request = URLRequest(url: newUrl)
      let session = URLSession(configuration: .default)
      let task = session.dataTask(with: request) { data, response, error in
          guard let data = data else{return}
          do{
              let result = try JSONDecoder().decode(TeamList.self, from: data)
              completionHandler(result)
          }catch{
              print(error)
              completionHandler(nil)
          }
          
      }
      task.resume()
  }
    
}
