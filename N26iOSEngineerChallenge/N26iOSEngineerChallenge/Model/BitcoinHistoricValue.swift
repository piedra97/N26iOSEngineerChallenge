//
//  BitcoinHistoricValue.swift
//  N26iOSEngineerChallenge
//
//  Created by Projectes on 2/4/21.
//

import Foundation

// MARK: - Empty
struct BitcoinHistoricValue: Codable {
    var bpi: [String: Double]
    
    func getDayFor(indexPath: IndexPath) -> String {
        return bpi.keys[getIndex(index: indexPath.row)]
    }
    
    func getValueFor(indexPath: IndexPath) -> String {
        return getFormatedValue(value: bpi.values[getIndex(index: indexPath.row)])
    }
    
    private func getIndex(index: Int) -> Dictionary<String, Double>.Index {
        return bpi.index(bpi.startIndex, offsetBy: index)
    }
    
    private func getFormatedValue(value: Double) -> String {
        return String(format: "%.2f", value) + Literals.CurrencySymbol.eur
    }
}

