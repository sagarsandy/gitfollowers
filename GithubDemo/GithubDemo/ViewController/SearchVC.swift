//
//  SearchVC.swift
//  GithubDemo
//
//  Created by Sagar on 17/12/25.
//

import UIKit

class SearchVC: UIViewController {
    
    let logoImageView = UIImageView()
    let usernameTextField = SSTextField(placeholder: "Enter username")
    let getFollowersButton = SSButton(title: "Get Followers", backgroundColor: .systemGreen)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()

        view.backgroundColor = .systemBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    

}

//: MARK: - UI Setup with auto layouts

extension SearchVC {
    private func configureUI() {
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")!
        view.addSubview(logoImageView)
        
        usernameTextField.delegate = self
        view.addSubview(usernameTextField)
        
        getFollowersButton.addTarget(self, action: #selector(pushToFollowerListVC), for: .touchUpInside)
        view.addSubview(getFollowersButton)
        
        LayoutUI()
        createDismissKeyboardTapGesture()
    }
    
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    private func LayoutUI() {
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])

        NSLayoutConstraint.activate([
            getFollowersButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            getFollowersButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            getFollowersButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            getFollowersButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField.text ?? "No text")
        textField.resignFirstResponder()
        pushToFollowerListVC()
        return true
    }
}

extension SearchVC {
    @objc private func pushToFollowerListVC() {
        print("Get Followers button tapped")
        guard let username = usernameTextField.text, !username.isEmpty else {
            showSSAlert(title: "Empty username", message: "Please enter a username to search", buttonTitle: "Ok")
            return
        }
        let followerListVC = FollowerListVC()
        followerListVC.username = username
        followerListVC.title = username
        navigationController?.pushViewController(followerListVC, animated: true)
    }
}
