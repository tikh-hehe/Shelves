//
//  RegisterVC.swift
//  Shelves
//
//  Created by tikh on 11.09.2023.
//

import UIKit

final class RegisterVC: BaseController<RegisterView> {
    
    // MARK: - Properties
    
    private var fieldValidations = [false, false, false]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myView.delegate = self
        myView.setTextFieldsDelegate(self)
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
    }
}

// MARK: - RegisterViewDelegate

extension RegisterVC: RegisterViewDelegate {
    
    func nextButtonTapped() {
        print(#function)
    }
    
    func textFieldDidChange() {
        print(#function)
    }
}

// MARK: - UITextFieldDelegate

extension RegisterVC: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard !textField.text!.isEmpty else {
            fieldValidations[textField.tag] = false
            showErrorOnTextField(false, on: textField)
            return
        }
        
        var isValid = false
        
        switch textField.tag {
        case 0:
            isValid = isValidEmailAddr(strToValidate: myView.mailTextField.text!)
        case 1:
            isValid = isValidPassword(strToValidate: myView.passwordTextField.text!)
        case 2:
            isValid = myView.passwordTextField.text! == myView.repeatPasswordTextField.text!
        default:
            break
        }
        
        fieldValidations[textField.tag] = isValid
        showErrorOnTextField(!isValid, on: myView.allTextFields[textField.tag])
        
        let allFieldsAreValid = fieldValidations.allSatisfy({$0})
        myView.nextButton.isEnabled = allFieldsAreValid
        myView.nextButton.alpha = allFieldsAreValid ? 1 : 0.5
    }
}

// MARK: - Validation

extension RegisterVC {
    
    private func isValidEmailAddr(strToValidate: String) -> Bool {
        let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"
        let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)
        return emailValidationPredicate.evaluate(with: strToValidate)
    }
    
    private func isValidPassword(strToValidate: String) -> Bool {
        let passwordValidationRegex =  "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,20}$"
        let passwordValidationPredicate = NSPredicate(format: "SELF MATCHES %@", passwordValidationRegex)
        return passwordValidationPredicate.evaluate(with: strToValidate)
    }
    
    private func showErrorOnTextField(_ state: Bool, on textField: UITextField) {
        let errorLabel = myView.allErrorLabels[textField.tag]
        if state {
            textField.layer.borderColor = UIColor.red.cgColor
            myView.addSubview(errorLabel)
            errorLabel.snp.makeConstraints { make in
                make.leading.equalToSuperview().inset(24)
                make.top.equalTo(textField.snp.bottom)
            }
        } else {
            textField.layer.borderColor = Constants.Colors.textSecondary2.cgColor
            errorLabel.removeFromSuperview()
        }
    }
}
