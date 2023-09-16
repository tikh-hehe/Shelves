//
//  HomeVC.swift
//  Shelves
//
//  Created by tikh on 16.09.2023.
//

import UIKit

final class HomeVC: UIViewController {
    
    // MARK: - Views
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    // MARK: - Init
    
    init(email: String) {
        emailLabel.text = email
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(emailLabel)
        view.backgroundColor = .systemBackground
        emailLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
