//
//  AppDelegate.swift
//  CafeSpot
//
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    
    let homeVC = HomeVC()
    let mapFindVC = MapFindVC()
    
    let navigationController = UINavigationController(rootViewController: homeVC)
    let tabbarController = UITabBarController()

    homeVC.tabBarItem = UITabBarItem.init(title: "홈", image: UIImage(systemName: "house"), tag: 0)
    mapFindVC.tabBarItem =  UITabBarItem.init(title: "지도 검색", image: UIImage(systemName: "map.fill"), tag: 1)

    tabbarController.viewControllers = [navigationController, mapFindVC]
    
    window?.rootViewController = tabbarController
    window?.makeKeyAndVisible()
    
    return true
  }
}
