//
//  DashboardContoller.swift
//  newproj
//
//  Created by CURRENTUSER on 3/7/19.
//  Copyright © 2019 ORGNAME. All rights reserved.
//

import UIKit

class DashboardContoller: UIViewController {

    @IBOutlet private var welcomeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeLabel.text = "Welcome " + user.value
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}
