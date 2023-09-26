//
//  TextFieldWithErrorView.swift
//  Shelves
//
//  Created by tikh on 22.09.2023.
//

import UIKit

final class TextFieldWithErrorView: UIView {
    
    // MARK: - Views
    
    var authTextField: AuthTextField!
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Некорректный ввод"
        label.font = .systemFont(ofSize: 10)
        label.textColor = .red
        return label
    }()
    
    // MARK: - Init
    
    init(placeholder: String, leftImage: UIImage, isSecured: Bool = false) {
        super.init(frame: .zero)
        authTextField = AuthTextField(placeholder: placeholder, leftImage: leftImage, isSecured: isSecured)
        
        addSubview(authTextField)
        addSubview(errorLabel)
        
        authTextField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(authTextField.snp.bottom).offset(4)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        
        errorLabel.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Functions
    
    func showError(_ state: Bool, text: String = Constants.ErrorNames.incorrectInput) {
        errorLabel.isHidden = !state
        errorLabel.text = text
        authTextField.layer.borderColor = state ? UIColor.red.cgColor : Constants.Colors.textSecondary2.cgColor
    }
}
