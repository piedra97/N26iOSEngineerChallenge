//
//  BitcoinCurrentValue.swift
//  N26iOSEngineerChallenge
//
//  Created by Projectes on 2/4/21.
//

import Foundation
// MARK: - Empty
// MARK: - Empty
struct BitCoinCurrentValue: Codable {
    let disclaimer, chartName: String
    let bpi: Bpi
}

// MARK: - Bpi
struct Bpi: Codable {
    let usd, gbp, eur: Currency

    enum CodingKeys: String, CodingKey {
        case usd = "USD"
        case gbp = "GBP"
        case eur = "EUR"
    }
}

// MARK: - Eur
struct Currency: Codable {
    let code, symbol, rate, description: String
    let rateFloat: Double

    enum CodingKeys: String, CodingKey {
        case code, symbol, rate
        case description = "description"
        case rateFloat = "rate_float"
    }
}
