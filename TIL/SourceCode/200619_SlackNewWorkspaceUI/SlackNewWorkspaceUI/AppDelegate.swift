//
//  AppDelegate.swift
//  SlackNewWorkspaceUI
//
//  Copyright © 2020 giftbot. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
    let createNewMSVC = CreateNewWSViewController()
    
    let navigationController = UINavigationController(rootViewController: createNewMSVC)
    navigationController.navigationBar.shadowImage = UIImage()
    navigationController.navigationBar.isTranslucent = false
    
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
    
    return true
  }
}
