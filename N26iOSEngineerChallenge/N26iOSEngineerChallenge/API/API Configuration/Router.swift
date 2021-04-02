//
//  Router.swift
//  N26iOSEngineerChallenge
//
//  Created by Projectes on 1/4/21.
//

import Foundation

enum Router {
    // Request endpoints
    case getBitcointFromTodayToTwoWeeks
    case getBitcoinCurrentValue
    
    //Gives the correct url scheme for each endpoint
    var scheme: String {
        switch self {
        case .getBitcointFromTodayToTwoWeeks, .getBitcoinCurrentValue:
            return "https"
        }
    }
    
    //Gives the correct host for each endpoint
    var host: String {
        switch self {
        case .getBitcointFromTodayToTwoWeeks, .getBitcoinCurrentValue:
            return "api.coindesk.com"
        }
    }
    
    //Gives the correct path for each endpoint
    var path: String {
        let currencyCode = "EUR"
        switch self {
        case .getBitcointFromTodayToTwoWeeks:
            return "/v1/bpi/historical/close.json"
        case .getBitcoinCurrentValue:
            return "v1/bpi/currentprice/" + currencyCode + ".json"
        }
    }
    
    //Gives the correct parameters for each endpoint
    var parameters: [URLQueryItem] {
        let formatDate = "yyyy-MM-dd"
        switch self {
        case .getBitcointFromTodayToTwoWeeks:
            return [URLQueryItem(name: "start", value: UtilsDate.getActualDate(dateFormat: formatDate)),
                    URLQueryItem(name: "end", value: UtilsDate.getDateFromTwoWeeks(dateFormat: formatDate))]
        case .getBitcoinCurrentValue:
            return [URLQueryItem(name: "", value: nil)]
        }
    }
    
    var method: String {
        switch self {
          case .getBitcointFromTodayToTwoWeeks, .getBitcoinCurrentValue:
            return "GET"
        }
      }
}
