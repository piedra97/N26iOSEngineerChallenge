//
//  BaseViewController.swift
//  N26iOSEngineerChallenge
//
//  Created by Projectes on 2/4/21.
//

import UIKit

class BaseViewController: UIViewController {
    
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - View configuration
    /**
     Displays a simple error dialog
     */
    func showErrorDialog(error: Error)
    {
        showDialog(title: Literals.Error.error,
                   message:   error.localizedDescription,
                   button: Literals.Actions.acceptAction)
    }
    
    /**
     Displays a simple dialog with a custom button text
     */
    func showDialog(title: String,
                    message: String,
                    button: String)
    {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: button,
                                      style: .default,
                                      handler: nil));
        self.present(alert,
                     animated: true,
                     completion: nil);
    }
    
    func presentEmptyState(message: String, tableView: UITableView) {
        tableView.setEmptyMessage(message: message)
    }
    
    func setUpViewControllerWith(title: String) {
        self.title = title
    }
}
