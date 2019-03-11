//
//  ProfileController.swift
//  newproj
//
//  Created by CURRENTUSER on 3/7/19.
//  Copyright © 2019 ORGNAME. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func logoutAction(_ sender: UIButton) {
        AppRouter.shared.logout()
    }
}
