//
//  BitcoinHistoricValueViewModel.swift
//  N26iOSEngineerChallenge
//
//  Created by Projectes on 3/4/21.
//

import Foundation

struct BitcoinHistoricValueViewModel {
    var values : [BitcoinValue]?
    
    init(historicValuesResponse: BitcoinHistoricValue?, currentValueResponse: BitcoinCurrentValue?) {
        values = []
        // Convert API response dictionary into a more suitable object
        if let historicValues = historicValuesResponse?.bpi {
            for (day, value) in  historicValues {
                values?.append(BitcoinValue(day: UtilsDate.stringToDate(date: day, dateFormat: Literals.DateFormats.yyyyMMDDFormat), value: value))
            }
            // Add today's bitcoin value in EUROS which is not returned in API response
            values?.append(BitcoinValue(day: Date(), value: currentValueResponse?.getBitcoinRateEur()))
            // Sort the values dictionary
            values?.sort {
                $0.day ?? Date() > $1.day ?? Date()
            }
        }
    }
    
    
}

struct BitcoinValue {
    var day : Date?
    var value : Double?
    
    init(day: Date?, value: Double?) {
        self.day = day
        self.value = value
    }
    
    func getDay() -> String {
        return UtilsDate.dateToString(date: day ?? Date(), dateFormat: Literals.DateFormats.yyyyMMDDFormat)
    }
    
    func getValue() -> String {
        if let valueClean = value {
            return String(format: "%.2f", valueClean) + Literals.Common.eurCurrencySymbol
        }
        return "--"
    }
}
