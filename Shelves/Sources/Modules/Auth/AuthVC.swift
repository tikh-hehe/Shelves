//
//  AuthVC.swift
//  Shelves
//
//  Created by tikh on 19.09.2023.
//

import UIKit

final class AuthVC: BaseController<AuthView> {
    
    private let validationManager = ValidationManager()
    var fieldValidations = [false, false]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myView.delegate = self
        myView.setTextFieldsDelegate(self)
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
    }
}

// MARK: - AuthTextFieldDelegate

extension AuthVC: AuthViewDelegate {
    func signInButtonTapped() {}
    
    func registerButtonTapped() {
        let vc = RegisterVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension AuthVC: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard !textField.text!.isEmpty else {
            fieldValidations[textField.tag] = false
            myView.allTextFields[textField.tag].showError(false)
           
            myView.signInButton.isEnabled =  validationManager.checkValidations(fieldValidations)
            myView.signInButton.alpha =  validationManager.checkValidations(fieldValidations) ? 1 : 0.5
            return
        }
        
        var isValid = false
        
        switch textField.tag {
        case 0:
            isValid = validationManager.isValidEmailAddr(strToValidate: textField.text ?? "")
        case 1:
            isValid = validationManager.isValidPassword(strToValidate: textField.text ?? "")
        default:
            break
        }
        
        fieldValidations[textField.tag] = isValid
        myView.allTextFields[textField.tag].showError(!isValid, text: Constants.ErrorNames.incorrectInput)

        myView.signInButton.isEnabled =  validationManager.checkValidations(fieldValidations)
        myView.signInButton.alpha =  validationManager.checkValidations(fieldValidations) ? 1 : 0.5
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

