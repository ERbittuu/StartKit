//
//  LoginController.swift
//  newproj
//
//  Created by Utsav Patel on 3/7/19.
//  Copyright © 2019 Solution Analysts. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet private var userField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func loginAction(_ sender: UIButton) {
        if let userName = userField.text,
            !userName.isEmpty {
            AppRouter.shared.login(for: userName)
        }
    }
}