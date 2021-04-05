//
//  NetworkRequest.swift
//  N26iOSEngineerChallenge
//
//  Created by Projectes on 5/4/21.
//

import Foundation

struct NetworkRequest {
    static let shared = NetworkRequest()
    
    // Disable default initializer so it can't be called from outside
    private init() {
        
    }
    
    static func makeBitcoinHistoricValuesRequest(success: @escaping (BitcoinHistoricValueViewModel) -> (), empty: @escaping (Bool) -> (), failure: @escaping (Error)->()) {
        var currentValueResponse: BitcoinCurrentValue?
        var bitcoinEurHistoricValueResponse: BitcoinHistoricValue?
        var bitcoinUsdHistoricValueResponse: BitcoinHistoricValue?
        var bitcoinGbpHistoricValueResponse: BitcoinHistoricValue?
        var networkError: Error?
        
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        ServiceLayer.request(router: Router.getBitcoinCurrentValue) { (result: Result<BitcoinCurrentValue?, Error>) in
            switch result {
            case .success(let response):
                currentValueResponse = response
                dispatchGroup.leave()
            case .failure(let error):
                networkError = error
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.enter()
        ServiceLayer.request(router: Router.getBitcoinFromTodayToTwoWeeksEur) { (result: Result<BitcoinHistoricValue? , Error>) in
            switch result {
            case .success(let response):
                bitcoinEurHistoricValueResponse = response
                dispatchGroup.leave()
            case .failure(let error):
                networkError = error
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.enter()
        ServiceLayer.request(router: Router.getBitcoinFromTodayToTwoWeeksUsd) { (result: Result<BitcoinHistoricValue? , Error>) in
            switch result {
            case .success(let response):
                bitcoinUsdHistoricValueResponse = response
                dispatchGroup.leave()
            case .failure(let error):
                networkError = error
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.enter()
        ServiceLayer.request(router: Router.getBitcoinFromTodayToTwoWeeksGbp) { (result: Result<BitcoinHistoricValue? , Error>) in
            switch result {
            case .success(let response):
                bitcoinGbpHistoricValueResponse = response
                dispatchGroup.leave()
            case .failure(let error):
                networkError = error
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            if let error = networkError {
                failure(error)
            } else {
                if let currentValue = currentValueResponse, let eurValue = bitcoinEurHistoricValueResponse, let usdValue = bitcoinUsdHistoricValueResponse, let gbpValue = bitcoinGbpHistoricValueResponse {
                    if eurValue.bpi.isEmpty {
                        empty(true)
                    } else {
                        let viewModel = BitcoinHistoricValueViewModel(historicValuesEurResponse: eurValue, historicValuesUsdResponse: usdValue, historicValuesGbpResponse: gbpValue, currentValueResponse: currentValue)
                        success(viewModel)
                    }
                }
            }
        }
    }
}
