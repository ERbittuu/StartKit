//
//  DashboardContoller.swift
//  newproj
//
//  Created by Utsav Patel on 3/7/19.
//  Copyright © 2019 Solution Analysts. All rights reserved.
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

