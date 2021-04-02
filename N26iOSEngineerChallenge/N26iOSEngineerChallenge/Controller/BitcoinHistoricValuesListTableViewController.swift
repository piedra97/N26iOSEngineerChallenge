//
//  BitcoinHistoricValuesListTableViewController.swift
//  N26iOSEngineerChallenge
//
//  Created by Projectes on 2/4/21.
//

import UIKit

class BitcoinHistoricValuesListTableViewController: BaseViewController {
    
    private var cellModel: BitcoinHistoricValue?
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Outlets
    @IBOutlet var tableView: UITableView!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableSettings()
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
    
    private func requestCurrentBitCoinValue() {
        ServiceLayer.request(router: Router.getBitcoinCurrentValue) { (result:
            Result<BitcoinCurrentValue?, Error>) in
            switch result {
            case .success(let response):
                self.processTodayValue(response: response)
            case .failure(let error):
                DispatchQueue.main.async {
                    super.showErrorDialog(error: error)
                }
            }
        }
    }
    
    // MARK: - Data management
    
    private func processSuccessData(response: BitcoinHistoricValue?) {
        cellModel = response
        checkIfResponseIsEmpty()
    }
    
    private func checkIfResponseIsEmpty() {
        if let responsebpi = self.cellModel?.bpi {
            if responsebpi.isEmpty {
                refreshControl.endRefreshing()
                presentEmptyState(message: Literals.EmptyState.historicValues, tableView: tableView)
            } else {
                restoreNotEmptyState(tableView: tableView)
                requestCurrentBitCoinValue()
            }
        }
    }
    
    private func processTodayValue(response: BitcoinCurrentValue?) {
        if let todayValue = response {
            addCurrentValueToHistoricModel(currentValue: todayValue)
        }
    }
    
    private func addCurrentValueToHistoricModel(currentValue: BitcoinCurrentValue?) {
        if let actualDate = UtilsDate.getActualDate(dateFormat: "yyyy-MM-dd") {
            refreshControl.endRefreshing()
            cellModel?.bpi[actualDate] = currentValue?.bpi?.eur?.rateFloat
            tableView.reloadData()
        }
    }
    
    //MARK: - View configuration
    private func setupTableSettings() {
        refreshControl.attributedTitle = NSAttributedString(string:Literals.Common.refreshControlDescription)
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    //MARK: - Action handlers
    @objc func refresh(_ sender: AnyObject) {
        requestHistoricBitcoinValue()
    }
}


//MARK: -TableViewDataSource & Delegate
extension BitcoinHistoricValuesListTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Api service don't retrieve todays bitcoin value
        self.cellModel?.bpi.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Literals.Identifiers.cellBitCoinValue, for: indexPath)
        cell.textLabel?.text = cellModel?.getDayFor(indexPath: indexPath)
        cell.detailTextLabel?.text = cellModel?.getValueFor(indexPath: indexPath)
        return cell
    }
    
    
    
}
