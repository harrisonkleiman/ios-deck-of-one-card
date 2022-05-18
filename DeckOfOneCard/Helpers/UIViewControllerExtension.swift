//
//  UIViewControllerExtension.swift
//  DeckOfOneCard
//
//  Created by Harrison Kleiman on 5/18/22.
//

import UIKit

extension UIViewController {
    
    // HAS TO BE LOCALIZED ERROR SO WE CAN PRINT THE error.errorDescription - localizedDescription STRIPS AWAY CUSTOM DESCRIPTIONS
    func presentErrorToUser(localizedError: LocalizedError) {
        
        let alertController = UIAlertController(title: "ERROR", message: localizedError.errorDescription, preferredStyle: .actionSheet)
        
        let dismissAction = UIAlertAction(title: "Ok", style: .cancel)
                alertController.addAction(dismissAction)
                present(alertController, animated: true)
    }
}
