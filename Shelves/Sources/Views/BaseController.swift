//
//  BaseController.swift
//  Shelves
//
//  Created by tikh on 14.09.2023.
//

import UIKit

class BaseController<CustomView: UIView>: UIViewController {
    
    var myView: CustomView {
        return view as! CustomView
    }

    override func loadView() {
        view = CustomView()
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable, message: "Loading this view controller from a nib is unsupported.")
    override convenience init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.init()
    }

    @available(*, unavailable, message: "Loading this view controller from a nib is unsupported.")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
