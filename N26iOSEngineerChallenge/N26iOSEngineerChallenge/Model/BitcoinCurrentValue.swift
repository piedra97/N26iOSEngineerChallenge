//
//  BitcoinCurrentValue.swift
//  N26iOSEngineerChallenge
//
//  Created by Projectes on 2/4/21.
//

import Foundation
// MARK: - Empty
struct BitcoinCurrentValue: Codable {
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
    let rateFloat: Double?

    enum CodingKeys: String, CodingKey {
        case rateFloat = "rate_float"
    }
}


