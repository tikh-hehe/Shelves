//
//  RegisterView.swift
//  Shelves
//
//  Created by tikh on 14.09.2023.
//

import UIKit

protocol RegisterViewDelegate: AnyObject {
    func nextButtonTapped()
    func textFieldDidChange()
}

final class RegisterView: UIView {
    
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
    
    private(set) lazy var mailTextField: UITextField = {
        let textField = AuthTextField(placeholder: "Электронная почта", leftImage: Constants.Images.profile)
        textField.keyboardType = .emailAddress
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textField.tag = 0
        return textField
    }()
    
    private(set) lazy var passwordTextField: UITextField = {
        let textField = AuthTextField(placeholder: "Введите пароль", leftImage: Constants.Images.lock, isSecured: true)
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textField.tag = 1
        return textField
    }()
    
    private(set) lazy var repeatPasswordTextField: UITextField = {
        let textField = AuthTextField(placeholder: "Повторите пароль", leftImage: Constants.Images.lock, isSecured: true)
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textField.tag = 2
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
    
    private(set) lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Продолжить", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.setTitleColor(.systemBackground, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.backgroundColor = Constants.Colors.main
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        button.isEnabled = false
        button.alpha = 0.5
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
    
    private let mailTextFieldErrorLabel: UILabel = {
        let label = UILabel()
        label.text = "Некорректный ввод"
        label.font = .systemFont(ofSize: 8)
        label.textColor = .red
        return label
    }()
    
    private let passwordTextFieldErrorLabel: UILabel = {
        let label = UILabel()
        label.text = "Некорректный ввод"
        label.font = .systemFont(ofSize: 8)
        label.textColor = .red
        return label
    }()
    
    private let repeatPasswordTextFieldErrorLabel: UILabel = {
        let label = UILabel()
        label.text = "Некорректный ввод"
        label.font = .systemFont(ofSize: 8)
        label.textColor = .red
        return label
    }()
    
    // MARK: - Properties
    
    weak var delegate: RegisterViewDelegate?
    lazy var allTextFields = [mailTextField, passwordTextField, repeatPasswordTextField]
    lazy var allErrorLabels = [mailTextFieldErrorLabel, passwordTextFieldErrorLabel, repeatPasswordTextFieldErrorLabel]
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Functions
    
    func setTextFieldsDelegate(_ delegate: UITextFieldDelegate) {
        allTextFields.forEach { $0.delegate = delegate }
    }
    
    // MARK: - Actions
    
    @objc private func nextButtonTapped() {
        delegate?.nextButtonTapped()
    }
    
    @objc private func textFieldDidChange() {
        delegate?.textFieldDidChange()
    }
    
    // MARK: - Layout
    
    private func addSubviews() {
        addSubview(userDataStackView)
        addSubview(nextButton)
        addSubview(alreadyHaveAccountStackView)
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
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
