//
//  BaseViewController.swift
//  N26iOSEngineerChallenge
//
//  Created by Projectes on 2/4/21.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Properties
    
    var indicatorView : UIActivityIndicatorView?
    
    
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
    
    
    func setUpViewControllerWith(title: String) {
        self.title = title
    }
    
    func showActivityIndicator(style: UIActivityIndicatorView.Style = .medium, frame: CGRect? = nil, center: CGPoint? = nil) {
        indicatorView = activityIndicator(style: style, frame: frame, center: center)
        if let indicator = indicatorView {
            self.view.addSubview(indicator)
            indicator.startAnimating()
        }
    }
    
    private func activityIndicator(style: UIActivityIndicatorView.Style = .medium, frame: CGRect? = nil, center: CGPoint? = nil) -> UIActivityIndicatorView {
        
        let activityIndicatorView = UIActivityIndicatorView(style: style)
        
        if let frame = frame {
            activityIndicatorView.frame = frame
        }
        
        if let center = center {
            activityIndicatorView.center = center
        }
        
        return activityIndicatorView
    }
    
    func hideActivityIndicator() {
        indicatorView?.isHidden = true
        indicatorView?.stopAnimating()
    }
    
}
