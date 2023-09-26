//
//  AuthView.swift
//  Shelves
//
//  Created by tikh on 19.09.2023.
//

import UIKit

protocol AuthViewDelegate: AnyObject {
    func signInButtonTapped()
    func registerButtonTapped()
}

final class AuthView: UIView {
    
    // MARK: - Views
    
    private lazy var userDataStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            authLabel,
            textFieldStackView
        ])
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private let authLabel: UILabel = {
        let label = UILabel()
        label.text = "Войти"
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            mailTextField,
            passwordTextField
        ])
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()

    private(set) lazy var mailTextField: TextFieldWithErrorView = {
        let textField = TextFieldWithErrorView(placeholder: "Электронная почта", leftImage: Constants.Images.profile)
        textField.authTextField.keyboardType = .emailAddress
        textField.authTextField.tag = 0
        return textField
    }()
    
    private(set) lazy var passwordTextField: TextFieldWithErrorView = {
        let textField = TextFieldWithErrorView(placeholder: "Введите пароль", leftImage: Constants.Images.lock, isSecured: true)
        textField.authTextField.tag = 1
        return textField
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Забыли пароль?", for: .normal)
        button.setTitleColor(Constants.Colors.main, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        return button
    }()
    
    private(set) lazy var signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.setTitleColor(.systemBackground, for: .normal)
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.backgroundColor = Constants.Colors.main
        button.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        button.isEnabled = false
        button.alpha = 0.5
        return button
    }()
    
    private lazy var integrationStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
        leftLine,
        loginThroughLabel,
        rightLine
        ])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var leftLine: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.line
        view.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width * 0.319)
            make.height.equalTo(1)
        }
        return view
    }()
    
    private lazy var rightLine: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.line
        view.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width * 0.319)
            make.height.equalTo(1)
        }
        return view
    }()
    
    private lazy var loginThroughLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.text = "Войти через"
        label.textColor = Constants.Colors.textSecondary4
        label.textAlignment = .center
        return label
    }()
    
    private(set) lazy var loginWithGoogleButton: UIButton = {
        let button = UIButton()
        button.setTitle("Продолжить через google", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.setTitleColor(Constants.Colors.main, for: .normal)
        
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.backgroundColor = Constants.Colors.grayButton
        button.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let googleIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.Images.google
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var noAccountYetStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            noAccountYetLabel,
            registerButton
        ])
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
    private let noAccountYetLabel: UILabel = {
        let label = UILabel()
        label.text = "Ещё нет аккаунта?"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Зарегистрироваться", for: .normal)
        button.setTitleColor(Constants.Colors.main, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    
    weak var delegate: AuthViewDelegate?
    lazy var allTextFields = [mailTextField, passwordTextField]
    
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
        allTextFields.forEach { $0.authTextField.delegate = delegate }
    }
    
    // MARK: - Actions
    
    @objc private func signInButtonTapped() {
        
    }
    
    @objc private func registerButtonTapped() {
        delegate?.registerButtonTapped()
    }
    
    // MARK: - Layout
    
    private func addSubviews() {
        addSubview(userDataStackView)
        addSubview(forgotPasswordButton)
        addSubview(signInButton)
        addSubview(integrationStackView)
        addSubview(loginWithGoogleButton)
        addSubview(noAccountYetStackView)
        
        loginWithGoogleButton.addSubview(googleIcon)
    }
    
    private func makeConstraints() {
        userDataStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.centerY.equalToSuperview().offset(-153)
        }
        
        forgotPasswordButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(24)
            make.top.equalTo(userDataStackView.snp.bottom).offset(6)
        }
        
        signInButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.top.equalTo(forgotPasswordButton.snp.bottom).offset(12)
            make.height.equalTo(52)
        }
        
        integrationStackView.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(14)
        }
        
        loginWithGoogleButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.top.equalTo(integrationStackView.snp.bottom).offset(20)
            make.height.equalTo(48)
        }
        
        googleIcon.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
        }
        
        noAccountYetStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
