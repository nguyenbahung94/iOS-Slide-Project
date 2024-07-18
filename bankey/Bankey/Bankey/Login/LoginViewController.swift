//
//  ViewController.swift
//  Bankey
//
//  Created by Ba Hung on 13/07/2024.
//

import UIKit

protocol LogoutDelegate: AnyObject {
    func didLogout()
}

protocol LoginViewControllerDelegate: AnyObject {
    func didLogin()
}

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    
    weak var delegate: LoginViewControllerDelegate?
    var userName: String? {
        return loginView.userNameTextField.text
    }
    
    var passWord: String? {
        return loginView.passwordTextField.text
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }

}

extension LoginViewController {
    
    private func style() {
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.text = "error message goes here"
        errorMessageLabel.isHidden = false
        
        
    }
    
    private func layout() {
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            loginView.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1),
        ])
        
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 1),
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor), 
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
            errorMessageLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
    }
}

extension LoginViewController {
    
    @objc
    private func signInTapped(sender: UIButton) {
        errorMessageLabel.isHidden = true
        login()
    }
    
    private func login() {
        guard let username = userName, let password = passWord else {
           assertionFailure("Username and password must not be nil")
            errorMessageLabel.isHidden = false
            return
        }
        
        if username.isEmpty || password.isEmpty {
            configureView(withMessage: "Username and password must not be empty")
        }
        
        if username == "Hung" && password == "123" {
            signInButton.configuration?.showsActivityIndicator = true
            delegate?.didLogin()
            signInButton.configuration?.showsActivityIndicator = false
        } else {
            configureView(withMessage: "Invalid username or password")
        }
    }
    
    private func configureView(withMessage message: String) {
        errorMessageLabel.text = message
        errorMessageLabel.isHidden = false
    }
}

