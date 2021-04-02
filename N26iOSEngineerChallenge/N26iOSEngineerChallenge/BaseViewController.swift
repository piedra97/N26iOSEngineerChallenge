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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
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
    
    func presentEmptyState(message: String) {
        //Configure empty message
        let labelRect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        let messageLabel = UILabel(frame: labelRect)
        messageLabel.text = message
        messageLabel.textColor = UIColor.black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.sizeToFit()
        
        //Add views
        
        self.view.addSubview(messageLabel)
    }
}
