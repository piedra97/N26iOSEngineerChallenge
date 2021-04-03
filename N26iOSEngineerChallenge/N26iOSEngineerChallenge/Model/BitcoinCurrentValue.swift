//
//  BitcoinCurrentValue.swift
//  N26iOSEngineerChallenge
//
//  Created by Projectes on 2/4/21.
//

import Foundation
// MARK: - Empty
struct BitcoinCurrentValue: Codable {
    let disclaimer, chartName: String?
    let bpi: Bpi?
    
    func getBitcoinRateEur() -> Double? {
        return self.bpi?.eur?.rateFloat
    }
    
    func getBitcoinRateUsd() -> Double? {
        return self.bpi?.usd?.rateFloat
    }
    
    func getBitcoinRateGbp() -> Double? {
        return self.bpi?.gbp?.rateFloat
    }
    
    func getEurSymbol() -> String? {
        return self.bpi?.eur?.symbol
    }
    
    func getUsdSymbol() -> String? {
        return self.bpi?.usd?.symbol
    }
    
    func getGbpSymbol() -> String? {
        return self.bpi?.gbp?.symbol
    }
}

// MARK: - Bpi
struct Bpi: Codable {
    let usd, gbp, eur: Currency?

    enum CodingKeys: String, CodingKey {
        case usd = "USD"
        case gbp = "GBP"
        case eur = "EUR"
    }
}

// MARK: - Eur
struct Currency: Codable {
    let code, symbol, rate, description: String?
    let rateFloat: Double?

    enum CodingKeys: String, CodingKey {
        case code, symbol, rate
        case description = "description"
        case rateFloat = "rate_float"
    }
}


