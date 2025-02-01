//
//  presenter.swift
//  SportsApp
//
//  Created by Andrew Emad on 01/02/2025.
//

import Foundation
class Present{
    var view : ViewInternetRetriveProtocol?
    func getData(sportConfig : Int){
        NetworkService.fetchDataFromJSONLeauge(sport: sportConfig) { res in
            guard let result = res else {print("watashiwa NIL desu");return}
            self.view?.retrieveFromInternet(res: result)
        }
    }
}
