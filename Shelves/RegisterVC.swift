//
//  RegisterVC.swift
//  Shelves
//
//  Created by tikh on 11.09.2023.
//

import UIKit

final class RegisterVC: UIViewController {
    
    // MARK: - Views
    
    private lazy var userDataStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            registerLabel,
            textFieldStackView,
            infoText
        ])
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private let registerLabel: UILabel = {
        let label = UILabel()
        label.text = "Регистрация"
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            mailTextField,
            passwordTextField,
            repeatPasswordTextField
        ])
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()
    
    private let mailTextField: UITextField = {
        let textfield = AuthTextField(placeholder: "Электронная почта", leftImage: Constants.Images.profile)
        return textfield
    }()
    
    private let passwordTextField: UITextField = {
        let textField = AuthTextField(placeholder: "Введите пароль", leftImage: Constants.Images.lock, isSecured: true)
        return textField
    }()
    
    private let repeatPasswordTextField: UITextField = {
        let textField = AuthTextField(placeholder: "Повторите пароль", leftImage: Constants.Images.lock, isSecured: true)
        return textField
    }()

    private let infoText: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.text = "Пароль должен содержать:\n · не менее 8 символов (не более 20)\n · 1 буква и 1 цифра\n · 1 спец. символ (например, # & ? ! @)"
        label.numberOfLines = 0
        label.textColor = .systemGray2
        return label
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Продолжить", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.setTitleColor(.systemBackground, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.backgroundColor = Constants.Colors.main
        return button
    }()
    
    private lazy var alreadyHaveAccountStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            alreadyHaveAccountLabel,
            signInButton
        ])
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
    private let alreadyHaveAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Уже есть аккаунт?"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(Constants.Colors.main, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubviews()
        makeConstraints()
    }
    
    // MARK: - Layout
    
    private func addSubviews() {
        view.addSubview(userDataStackView)
        view.addSubview(nextButton)
        view.addSubview(alreadyHaveAccountStackView)
    }
    
    private func makeConstraints() {
        userDataStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.centerY.equalToSuperview().offset(-88)
        }
        
        nextButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.bottom.equalTo(alreadyHaveAccountStackView.snp.top).offset(-72)
            make.height.equalTo(52)
        }
        
        alreadyHaveAccountStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
