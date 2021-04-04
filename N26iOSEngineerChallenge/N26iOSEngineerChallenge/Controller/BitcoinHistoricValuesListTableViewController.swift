//
//  BitcoinHistoricValuesListTableViewController.swift
//  N26iOSEngineerChallenge
//
//  Created by Projectes on 2/4/21.
//

import UIKit

class BitcoinHistoricValuesListTableViewController: BaseViewController {
    
    private var cellModel: [BitcoinValue]?
    
    // MARK: - Outlets
    @IBOutlet var tableView: UITableView!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchBitcoinHistoricValues()
        setUpViewControllerWith(title: Literals.ViewControllerTitles.bitcoinHistoricValueTitle)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        deselectCell()
    }
    
    // MARK: - API Requests
    
    private func fetchBitcoinHistoricValues() {
        var currentValueResponse: BitcoinCurrentValue?
        var bitcoinEurHistoricValueResponse: BitcoinHistoricValue?
        var bitcoinUsdHistoricValueResponse: BitcoinHistoricValue?
        var bitcoinGbpHistoricValueResponse: BitcoinHistoricValue?
        var networkError: Error?
        
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        ServiceLayer.request(router: Router.getBitcoinCurrentValue) { (result:
                                                                        Result<BitcoinCurrentValue?, Error>) in
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
                super.showErrorDialog(error: error)
                super.presentEmptyState(message: Literals.EmptyState.historicValues, tableView: self.tableView)
            } else {
                if let currentValue = currentValueResponse, let eurValue = bitcoinEurHistoricValueResponse, let usdValue = bitcoinUsdHistoricValueResponse, let gbpValue = bitcoinGbpHistoricValueResponse {
                    if eurValue.bpi.isEmpty {
                        super.presentEmptyState(message: Literals.EmptyState.historicValues, tableView: self.tableView)
                    } else {
                        let viewModel = BitcoinHistoricValueViewModel(historicValuesEurResponse: eurValue, historicValuesUsdResponse: usdValue, historicValuesGbpResponse: gbpValue, currentValueResponse: currentValue)
                        self.cellModel = viewModel.values
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    // MARK: - View configuration
    
    private func deselectCell() {
        // We need to deselct row manually because controller is not a UITableViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    // MARK: - Navigation Management
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Literals.Segues.goToBitcoinValueDetails,
              let destination = segue.destination as? BitcoinValueDetailViewController,
              let cell = sender as? UITableViewCell,
              let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        let bitcoinValue = cellModel?[indexPath.row]
        destination.bitcoinValue = bitcoinValue
    }
    
}

//MARK: -TableViewDataSource & Delegate

extension BitcoinHistoricValuesListTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Api service don't retrieve todays bitcoin value
        self.cellModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Literals.Identifiers.cellBitCoinValue, for: indexPath)
        cell.textLabel?.text = cellModel?[indexPath.row].getDay()
        cell.detailTextLabel?.text = cellModel?[indexPath.row].getValueEur()
        return cell
    }
}
