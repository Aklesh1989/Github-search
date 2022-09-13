//
//  Extension.swift
//  GitUsers
//
//  Created by Aklesh on 13/09/22.
//

import Foundation
import UIKit
import MBProgressHUD

extension UIViewController {
    
    func showAlertWith(message: AlertMessage , style: UIAlertController.Style = .alert) {
        let alertController = UIAlertController(title: message.title, message: message.body, preferredStyle: style)
        let action = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func shouldHideLoader(isHidden: Bool) {
        if !isHidden {
            MBProgressHUD.hide(for: self.view, animated: true)
        } else {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
    }
    
}

public extension NSObject {
    class var nameOfClass: String {
        let componentsList = NSStringFromClass(self).split(separator: ".").map(String.init)
        return componentsList.last!
    }
}
