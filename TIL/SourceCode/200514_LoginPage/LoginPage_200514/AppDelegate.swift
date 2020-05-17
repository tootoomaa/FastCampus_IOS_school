//
//  AppDelegate.swift
//  LoginPage_200514
//
//  Created by 김광수 on 2020/05/14.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    struct SavedUserData {
        static var mainview = "mainview"
        static var loginStatus = "loginstatus"
        static var userName = "username"
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
     
        window = UIWindow()
        if let view = UserDefaults.standard.string(forKey: SavedUserData.mainview) {
            if view == "MainVC" {
                window?.rootViewController = MainVC()
            } else {
                window?.rootViewController = LoginVC()
            }
        }
    
        window?.makeKeyAndVisible()
        return true
    }

}

