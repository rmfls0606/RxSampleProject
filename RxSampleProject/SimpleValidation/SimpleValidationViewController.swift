//
//  SimpleValidationViewController.swift
//  RxSampleProject
//
//  Created by 이상민 on 8/20/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

private let minimalUsernameLength = 5
private let minimalPasswordLength = 5

final class SimpleValidationViewController: BaseViewController {
    private let usernameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.textColor = .black
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 17)
        textField.placeholder = "Username has to be at least \(minimalUsernameLength) characters"
        return textField
    }()
    
    private let usernameValidationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private let passwordTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.textColor = .black
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 17)
        textField.placeholder = "Password has to be at least \(minimalPasswordLength) characters"
        return textField
    }()
    
    private let passwordValidationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private let successButton: UIButton = {
        let button = UIButton()
        button.setTitle("Do something", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.isEnabled = false
        button.backgroundColor = .green
        return button
    }()
    
    override func configureHierarchy() {
        view.addSubview(usernameTitleLabel)
        view.addSubview(usernameTextField)
        view.addSubview(usernameValidationLabel)
        
        view.addSubview(passwordTitleLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordValidationLabel)
        
        view.addSubview(successButton)
    }
    
    override func configureLayout() {
        usernameTitleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameTitleLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(36)
        }
        
        usernameValidationLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        passwordTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameValidationLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTitleLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(36)
        }
        
        passwordValidationLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        successButton.snp.makeConstraints { make in
            make.top.equalTo(passwordValidationLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(44)
        }
    }
    
    override func configureView() {
        view.backgroundColor = .white
    }
}
