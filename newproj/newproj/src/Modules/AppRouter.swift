//
//  AppRouter.swift
//  newproj
//
//  Created by Utsav Patel on 3/7/19.
//  Copyright © 2019 Solution Analysts. All rights reserved.
//

import UIKit

class AppRouter {

    static let shared = AppRouter()

    private class Config {
        weak var appDelegate: AppDelegate?
    }
    private static let config = Config()

    class func setup(appDelegate: AppDelegate) {
        AppRouter.config.appDelegate = appDelegate
    }

    private init() {
        guard AppRouter.config.appDelegate != nil else {
            fatalError("Error - you must call setup before accessing AppRouter.shared")
        }
    }

    private var mainWindow: UIWindow? {
        return AppRouter.config.appDelegate?.window
    }

    func startApp() {
        // Print Environment
        Environment.printEnv()
        MyClass.init().test()
        let isLogin = !user.value.isEmpty
        if isLogin {
            openHome()
        } else {
            openLogin()
        }
        mainWindow?.makeKeyAndVisible()
    }

    private func openHome() {
        let homeVC: HomeTabController = UIStoryboard(storyboard: .main).instantiate()
        mainWindow?.switchRootViewController(to: homeVC,
                                             options: .transitionFlipFromLeft, {
                                                homeVC.selectedIndex = 0
        })
    }

    private func openLogin() {
        let loginVC: LoginController = UIStoryboard(storyboard: .main).instantiate()
        mainWindow?.switchRootViewController(to: loginVC,
                                             options: .transitionFlipFromRight)
    }
}

extension AppRouter {

    func login(for userName: String) {
        // setup User-Data
        user.value = userName

        openHome()
    }

    func logout() {
        openLogin()

        // Cleanup User-Data
        user.value = ""
    }
}
