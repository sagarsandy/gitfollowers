//
//  VCExtension.swift
//  GithubDemo
//
//  Created by Sagar on 17/12/25.
//

import UIKit

extension UIViewController {
    func showSSAlert(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = SSAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
