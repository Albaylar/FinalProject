//
//  HandleError.swift
//  SimpraFinalProject
//
//  Created by Furkan Deniz Albaylar on 24.01.2023.
//

import Foundation
import UIKit
extension UIViewController{
    @objc func handleError(_ notification: Notification) {
        if let text = notification.object as? String {
            let alert = UIAlertController(title: NSLocalizedString("Error", comment: "Error"), message: text, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "OK"), style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
