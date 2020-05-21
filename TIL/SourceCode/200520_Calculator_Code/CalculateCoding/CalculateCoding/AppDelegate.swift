//
//  AppDelegate.swift
//  CalculateCoding
//
//  Created by 김광수 on 2020/05/21.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.rootViewController = CalculateMainView()
        window?.makeKeyAndVisible()
        return true
    }
}

