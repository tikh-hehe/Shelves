//
//  AuthManager.swift
//  Shelves
//
//  Created by tikh on 16.09.2023.
//

import FirebaseAuth

final class AuthManager {
    
    static let shared = AuthManager()
    
    private init() {}
    
    func createUser(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let authResult else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Не удалось получить пользователя"])
                completion(.failure(error))
                return
            }
            
            completion(.success(authResult.user))
        }
    }
}
