//
//  BitcoinValueDetailTableViewController.swift
//  N26iOSEngineerChallenge
//
//  Created by Projectes on 4/4/21.
//

import UIKit

class BitcoinValueDetailViewController: BaseViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var labelEurPricePaceholder: UILabel!
    @IBOutlet weak var labelEurPriceValue: UILabel!
    @IBOutlet weak var labelUsdPricePlaceholder: UILabel!
    @IBOutlet weak var labelUsdPriceValue: UILabel!
    @IBOutlet weak var labelGbpPricePlaceholder: UILabel!
    @IBOutlet weak var labelGbpPriceValue: UILabel!
    
    // MARK: - Properties
    
    var bitcoinValue: BitcoinValue?
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: - View configuration

    private func configureView() {
        setUpViewControllerWith(title: bitcoinValue?.getDay() ?? Literals.Common.emptyString)
        fillViewsWithData()
    }
    
    private func fillViewsWithData() {
        labelEurPricePaceholder.text = Literals.LabelPlaceholder.valueEurPlaceholder
        labelUsdPricePlaceholder.text = Literals.LabelPlaceholder.valueUsdPlaceholder
        labelGbpPricePlaceholder.text = Literals.LabelPlaceholder.valueGbpPlaceholder
        labelEurPriceValue.text = bitcoinValue?.getValueEur()
        labelUsdPriceValue.text = bitcoinValue?.getValueUSD()
        labelGbpPriceValue.text = bitcoinValue?.getValueGBP()
    }

}
