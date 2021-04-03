//
//  BitcoinHistoricValueViewModel.swift
//  N26iOSEngineerChallenge
//
//  Created by Projectes on 3/4/21.
//

import Foundation

struct BitcoinHistoricValueViewModel {
    var values : [BitcoinValue]?
    
    init(historicValuesEurResponse: BitcoinHistoricValue?, historicValuesUsdResponse: BitcoinHistoricValue?, historicValuesGbpResponse: BitcoinHistoricValue?, currentValueResponse: BitcoinCurrentValue?) {
        values = []
        // Add today's bitcoin value in EUROS which is not returned in API response
        values?.append(BitcoinValue(day: Date(), valueEUR: currentValueResponse?.getBitcoinRateEur(), valueUSD: currentValueResponse?.getBitcoinRateUsd(), valueGBP: currentValueResponse?.getBitcoinRateGbp()))
        
        // Convert API response dictionary into a more suitable object
        if let historicEurValues = historicValuesEurResponse?.bpi {
            for (day, value) in  historicEurValues {
                var bitcoinValue = BitcoinValue()
                bitcoinValue.day = UtilsDate.stringToDate(date: day, dateFormat: Literals.DateFormats.yyyyMMDDFormat)
                bitcoinValue.valueEUR = value
                if let historicUsdValues = historicValuesUsdResponse?.bpi {
                    bitcoinValue.valueUSD = historicUsdValues[day]
                }
                if let historicGbpValues = historicValuesGbpResponse?.bpi {
                    bitcoinValue.valueGBP = historicGbpValues[day]
                }
                values?.append(bitcoinValue)
            }
        }
        // Sort the values dictionary
        self.values?.sort {
            $0.day ?? Date() > $1.day ?? Date()
        }
    }
}


struct BitcoinValue {
    var day : Date?
    var valueEUR : Double?
    var valueUSD : Double?
    var valueGBP : Double?
    
    init () {
        
    }
    
    init(day: Date?, valueEUR: Double?, valueUSD: Double?, valueGBP: Double?) {
        self.day = day
        self.valueEUR = valueEUR
        self.valueUSD = valueUSD
        self.valueGBP = valueGBP
    }
    
    func getDay() -> String {
        return UtilsDate.dateToString(date: day ?? Date(), dateFormat: Literals.DateFormats.yyyyMMDDFormat)
    }
    
    func getValueEur() -> String {
        if let valueClean = valueEUR {
            return String(format: "%.2f", valueClean) + (Literals.CurrencySymbol.eur)
        }
        return "--"
    }
    
    func getValueUSD() -> String {
        if let valueClean = valueUSD {
            return String(format: "%.2f", valueClean) + (Literals.CurrencySymbol.usd)
        }
        return "--"
    }
    
    func getValueGBP() -> String {
        if let valueClean = valueGBP {
            return String(format: "%.2f", valueClean) + (Literals.CurrencySymbol.gbp)
        }
        return "--"
    }
}
