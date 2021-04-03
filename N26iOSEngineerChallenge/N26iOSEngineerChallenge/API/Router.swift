//
//  Router.swift
//  N26iOSEngineerChallenge
//
//  Created by Projectes on 1/4/21.
//

import Foundation

enum Router {
    // Request endpoints
    case getBitcoinCurrentValue
    case getBitcoinFromTodayToTwoWeeksEur
    case getBitcoinFromTodayToTwoWeeksUsd
    case getBitcoinFromTodayToTwoWeeksGbp
    
    //Gives the correct url scheme for each endpoint
    var scheme: String {
        switch self {
        case .getBitcoinFromTodayToTwoWeeksEur, .getBitcoinFromTodayToTwoWeeksUsd, .getBitcoinFromTodayToTwoWeeksGbp, .getBitcoinCurrentValue:
            return "https"
        }
    }
    
    //Gives the correct host for each endpoint
    var host: String {
        switch self {
        case .getBitcoinFromTodayToTwoWeeksEur, .getBitcoinFromTodayToTwoWeeksUsd, .getBitcoinFromTodayToTwoWeeksGbp, .getBitcoinCurrentValue:
            return "api.coindesk.com"
        }
    }
    
    //Gives the correct path for each endpoint
    var path: String {
        switch self {
        case .getBitcoinFromTodayToTwoWeeksEur, .getBitcoinFromTodayToTwoWeeksUsd, .getBitcoinFromTodayToTwoWeeksGbp :
            return "/v1/bpi/historical/close.json"
        case .getBitcoinCurrentValue:
            return "/v1/bpi/currentprice.json"
        }
    }
    
    //Gives the correct parameters for each endpoint
    var parameters: [URLQueryItem]? {
        let formatDate = Literals.DateFormats.yyyyMMDDFormat
        let currencyEur = "EUR"
        let currencyUsd = "USD"
        let currencyGbp = "GBP"
        switch self {
        case .getBitcoinFromTodayToTwoWeeksEur:
            return [URLQueryItem(name:"currency", value: currencyEur),
                    URLQueryItem(name: "start", value: UtilsDate.getDateFromTwoWeeksBehind(dateFormat: formatDate)),
                    URLQueryItem(name: "end", value: UtilsDate.getActualDate(dateFormat: formatDate))]
        case .getBitcoinFromTodayToTwoWeeksUsd:
            return [URLQueryItem(name:"currency", value: currencyUsd),
                    URLQueryItem(name: "start", value: UtilsDate.getDateFromTwoWeeksBehind(dateFormat: formatDate)),
                    URLQueryItem(name: "end", value: UtilsDate.getActualDate(dateFormat: formatDate))]
        case .getBitcoinFromTodayToTwoWeeksGbp:
            return [URLQueryItem(name:"currency", value: currencyGbp),
                    URLQueryItem(name: "start", value: UtilsDate.getDateFromTwoWeeksBehind(dateFormat: formatDate)),
                    URLQueryItem(name: "end", value: UtilsDate.getActualDate(dateFormat: formatDate))]
        case .getBitcoinCurrentValue:
            return nil
        }
    }
    
    var method: String {
        switch self {
        case .getBitcoinFromTodayToTwoWeeksEur, .getBitcoinFromTodayToTwoWeeksUsd, .getBitcoinFromTodayToTwoWeeksGbp, .getBitcoinCurrentValue:
            return "GET"
        }
    }
}
