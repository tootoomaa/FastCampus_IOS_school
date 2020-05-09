//
//  SceneDelegate.swift
//  200508_TabBarController_new
//
//  Created by 김광수 on 2020/05/09.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        let firstVC = FirstViewController()
        let secondVC = SecondViewController()
        let thirdVC = ThirdViewController()
            
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [firstVC, secondVC, thirdVC]
        
        firstVC.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 0)
        secondVC.tabBarItem = UITabBarItem(title: "SecondVC", image: UIImage(named: "bolt.circle") , tag: 1)
        thirdVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 2)
        
        window?.rootViewController = tabBarController
        window?.backgroundColor = .systemBackground
        window?.makeKeyAndVisible()
    }
}

