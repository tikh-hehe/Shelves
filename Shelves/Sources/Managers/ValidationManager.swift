//
//  ValidationManager.swift
//  Shelves
//
//  Created by tikh on 22.09.2023.
//

import UIKit

final class ValidationManager {
    
    func isValidEmailAddr(strToValidate: String) -> Bool {
        let emailValidationRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)
        return emailValidationPredicate.evaluate(with: strToValidate)
    }
    
    func isValidPassword(strToValidate: String) -> Bool {
        let passwordValidationRegex =  "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,20}$"
        let passwordValidationPredicate = NSPredicate(format: "SELF MATCHES %@", passwordValidationRegex)
        return passwordValidationPredicate.evaluate(with: strToValidate)
    }
    
    func checkValidations(_ fieldValidations: [Bool]) -> Bool {
        let allFieldsAreValid = fieldValidations.allSatisfy({$0})
        return allFieldsAreValid
    }
}
