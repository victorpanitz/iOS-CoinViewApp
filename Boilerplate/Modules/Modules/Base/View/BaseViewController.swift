//
//  BaseView.swift
//
//  Created by MARCELO GRACIETTI on 08/11/16.
//  Copyright © 2016 Cheesecake Labs. All rights reserved.
//

import UIKit
import MBProgressHUD
import Localize_Swift

class BaseViewController: UIViewController, BaseView {

    // MARK: Properties
    
    var progressHUD: MBProgressHUD?
    
    fileprivate var internalScrollView: UIScrollView?
    
    // MARK: Methods
    
    func showLoading() {
        let topmostViewController = findTopmostViewController()
        progressHUD = MBProgressHUD.showAdded(to: topmostViewController.view, animated: true)
        progressHUD?.mode = MBProgressHUDMode.indeterminate
    }
    
    func hideLoading() {
        self.progressHUD?.hide(animated: true)
    }
    
    func showMessage(_ message: String?, withTitle title: String?) {
        let errorMessage = message ?? "GENERIC_ERROR_MESSAGE".localized()
        let errorTitle = title ?? "ERROR".localized()
        let errorController = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        errorController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(errorController, animated: true, completion: nil)
    }
    
    func showError(_ message: String?) {
        let errorMessage = message ?? "GENERIC_ERROR_MESSAGE".localized()
        let errorController = UIAlertController(title: "TITLE_ERROR".localized(), message: errorMessage, preferredStyle: .alert)
        errorController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(errorController, animated: true, completion: nil)
    }
    
    func setupKeyboardNotifications(with scrollView: UIScrollView?) {
        internalScrollView = scrollView
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // MARK: Keyboard Notifications
    func keyboardWillShow(notification: NSNotification) {
        guard let info = notification.userInfo,
              let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size else { return }
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height + 15.0, right: 0.0)
        
        internalScrollView?.contentInset = contentInsets
        internalScrollView?.scrollIndicatorInsets = contentInsets
        
        var aRect = view.frame
        aRect.size.height -= keyboardSize.height
        guard let activeFieldPresent = findActiveTextField(view.subviews) else { return }
        
        if (!aRect.contains(activeFieldPresent.frame.origin))
        {
            internalScrollView?.scrollRectToVisible(activeFieldPresent.frame, animated: true)
        }
    }
    
    func keyboardWillBeHidden(notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        internalScrollView?.contentInset = contentInsets
        internalScrollView?.scrollIndicatorInsets = contentInsets
    }
}
