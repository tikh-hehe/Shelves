//
//  RegisterVC.swift
//  Shelves
//
//  Created by tikh on 11.09.2023.
//

import UIKit

final class RegisterVC: BaseController<RegisterView> {
    
    // MARK: - Properties
    
    private let validationManager = ValidationManager()
    var fieldValidations = [false, false, false]
    
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
        AuthManager.shared.createUser(
            email: myView.mailTextField.authTextField.text ?? "",
            password: myView.passwordTextField.authTextField.text ?? ""
        ) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let user):
                let vc = HomeVC(email: user.email ?? "Нет почты")
                navigationController?.pushViewController(vc, animated: true)
                
            case .failure(let error):
                let alert = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ОК", style: .cancel))
                present(alert, animated: true)
            }
        }
    }
    
    func signInButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITextFieldDelegate

extension RegisterVC: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard !textField.text!.isEmpty else {
            fieldValidations[textField.tag] = false
            myView.allTextFields[textField.tag].showError(false)
            myView.nextButton.isEnabled = validationManager.checkValidations(fieldValidations)
            myView.nextButton.alpha = validationManager.checkValidations(fieldValidations) ? 1 : 0.5
            return
        }
        
        var isValid = false
        
        switch textField.tag {
        case 0:
            isValid = validationManager.isValidEmailAddr(strToValidate: textField.text ?? "")
        case 1:
            isValid = validationManager.isValidPassword(strToValidate: textField.text ?? "")
        case 2:
            isValid = myView.passwordTextField.authTextField.text! == myView.repeatPasswordTextField.authTextField.text!
        default:
            break
        }
        
        fieldValidations[textField.tag] = isValid
        myView.allTextFields[textField.tag].showError(!isValid, text: Constants.ErrorNames.incorrectInput)

        myView.nextButton.isEnabled =  validationManager.checkValidations(fieldValidations)
        myView.nextButton.alpha =  validationManager.checkValidations(fieldValidations) ? 1 : 0.5
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
