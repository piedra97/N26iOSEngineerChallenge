//
//  Literals.swift
//  N26iOSEngineerChallenge
//
//  Created by Projectes on 2/4/21.
//

import Foundation

struct Literals {
    
    struct Error {
        static let error = "Error"
        static let api_error = "Something went wrong when trying to connect to the server"
    }
    
    struct Actions {
        static let acceptAction = "Accept"
    }
    
    struct EmptyState {
        static let historicValues = "The list of historic values is empty"
    }
    
    struct Identifiers {
        static let cellBitCoinValue = "BitCoinValueCell"
    }
    
    struct Common {
        static let refreshControlDescription = "Pull to refresh"
        static let emptyString = "--"
    }
    
    struct DateFormats {
        static let yyyyMMDDFormat = "yyyy-MM-dd"
    }
    
    struct CurrencySymbol {
        // Tried to retrieve currency symbols with api response but format was wrong retrieved
        static let eur = "€"
        static let usd = "$"
        static let gbp = "£"
    }
    
    struct Segues {
        static let goToBitcoinValueDetails = "GoToBitcoinValueDetail"
    }
    
    struct LabelPlaceholder {
        static let valueEurPlaceholder = "Value in EUR: "
        static let valueUsdPlaceholder = "Value in USD: "
        static let valueGbpPlaceholder = "Value in GBP: "
    }
    
    struct ViewControllerTitles {
        static let bitcoinHistoricValueTitle = "Bitcoin historic value"
    }
}
