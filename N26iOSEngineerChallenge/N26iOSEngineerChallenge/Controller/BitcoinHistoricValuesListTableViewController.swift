//
//  BitcoinHistoricValuesListTableViewController.swift
//  N26iOSEngineerChallenge
//
//  Created by Projectes on 2/4/21.
//

import UIKit

class BitcoinHistoricValuesListTableViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Properties
    private var cellModel: [BitcoinValue]?
    
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
        showActivityIndicator(style: .large, center: self.view.center)
        NetworkRequest.shared.makeBitcoinHistoricValuesRequest { (bitcoinValue) in
            self.processSuccessDataFromAPI(successData: bitcoinValue)
        } empty: { (isEmpty) in
            if isEmpty {
                self.presentEmptyState()
            }
        } failure: { (error) in
            self.processErrorData(error: error)
        }
        hideActivityIndicator()
    }
    
    // MARK: - View configuration
    
    private func deselectCell() {
        // We need to deselct row manually because controller is not a UITableViewController
        tableView.deselectCell()
    }
    
    private func processSuccessDataFromAPI(successData: BitcoinHistoricValueViewModel) {
        self.cellModel = successData.values
        self.tableView.reloadData()
    }
    
    private func presentEmptyState() {
        self.tableView.setEmptyMessage(message: Literals.EmptyState.historicValues)
    }
    
    private func processErrorData(error: Error) {
        super.showErrorDialog(error: error)
        presentEmptyState()
        
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
