//
//  AuthTextField.swift
//  Shelves
//
//  Created by tikh on 11.09.2023.
//

import UIKit

final class AuthTextField: UITextField {
    
    // MARK: - Views
    
    private lazy var isSecuredButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(isSecuredButtonTapped), for: .touchUpInside)
        button.setImage(Constants.Images.eyeSlash, for: .normal)
        return button
    }()
    
    // MARK: - Properties
    
    private var isPasswordHidden = true
    
    // MARK: - Init
    
    convenience init(placeholder: String, leftImage: UIImage, isSecured: Bool = false) {
        self.init()
        
        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: Constants.Colors.textSecondary3]
        )
        
        makeLeftView(with: leftImage)
        
        if isSecured {
            isSecureTextEntry = true
            makeRightView()
        }
        
        snp.makeConstraints { make in
            make.height.equalTo(46)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        font = .systemFont(ofSize: 16)
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = Constants.Colors.textSecondary2.cgColor
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc func isSecuredButtonTapped(_ button: UIButton) {
        let image = isPasswordHidden ? Constants.Images.eyeOpen : Constants.Images.eyeSlash
        button.setImage(image, for: .normal)
        isSecureTextEntry = !isPasswordHidden
        isPasswordHidden.toggle()
    }
    
    // MARK: - Private Functions
    
    private func makeLeftView(with image: UIImage) {
        let view = UIView()
        let leftImageView = UIImageView(image: image)
        view.addSubview(leftImageView)
        
        leftImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(8)
            make.verticalEdges.equalToSuperview().inset(12)
        }
        
        leftView = view
        leftViewMode = .always
    }
    
    private func makeRightView() {
        let view = UIView()
        view.addSubview(isSecuredButton)
        
        isSecuredButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(8)
            make.verticalEdges.equalToSuperview().inset(12)
        }
        
        rightView = view
        rightViewMode = .always
    }
    
    private func wrongEmailLabel() {
        let label = UILabel()
        label.text = "Некорректный ввод"
        label.textColor = .red
        
        addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        }
    }
}
