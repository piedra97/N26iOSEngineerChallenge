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
        requestHistoricBitcoinValue()
    }
    
    // MARK: - API Requests
    
    private func requestHistoricBitcoinValue() {
        ServiceLayer.request(router: Router.getBitcointFromTodayToTwoWeeks) { (result: Result<BitcoinHistoricValue? , Error>) in
            switch result {
            case .success(let response):
                self.processSuccessData(response: response)
            case .failure(let error):
                DispatchQueue.main.async {
                    super.showErrorDialog(error: error)
                }
            }
        }
    }
    
    private func requestCurrentBitCoinValue(responseHistoricValues: BitcoinHistoricValue?) {
        ServiceLayer.request(router: Router.getBitcoinCurrentValue) { (result:
            Result<BitcoinCurrentValue?, Error>) in
            switch result {
            case .success(let response):
                self.processTodayValue(responseHistoricValues: responseHistoricValues, responseCurrentValue: response)
            case .failure(let error):
                DispatchQueue.main.async {
                    super.showErrorDialog(error: error)
                }
            }
        }
    }
    
    // MARK: - Data management
    
    private func processSuccessData(response: BitcoinHistoricValue?) {
        checkIfResponseIsEmpty(response: response)
    }
    
    private func checkIfResponseIsEmpty(response: BitcoinHistoricValue?) {
        if let responsebpi = response?.bpi {
            if responsebpi.isEmpty {
                presentEmptyState(message: Literals.EmptyState.historicValues, tableView: tableView)
            } else {
                requestCurrentBitCoinValue(responseHistoricValues: response)
            }
        }
    }
    
    private func processTodayValue(responseHistoricValues: BitcoinHistoricValue?, responseCurrentValue: BitcoinCurrentValue?) {
            let viewModel = BitcoinHistoricValueViewModel(historicValuesResponse: responseHistoricValues, currentValueResponse: responseCurrentValue)
        self.cellModel = viewModel.values
        tableView.reloadData()
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
        cell.detailTextLabel?.text = cellModel?[indexPath.row].getValue()
        return cell
    }
}
