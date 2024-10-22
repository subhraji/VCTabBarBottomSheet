//
//  SceneDelegate.swift
//  TestTabbarBottomsheet
//
//  Created by Subhrajit Deb on 07/10/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
        
        func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            guard let windowScene = scene as? UIWindowScene else { return }
            
            window = UIWindow(windowScene: windowScene)
            
            let mainViewController = MainViewController()
            let navigationController = UINavigationController(rootViewController: mainViewController)
            
            let secondViewController = SecondViewController()
            let navigationController2 = UINavigationController(rootViewController: secondViewController)
            
            //tab bar
            let tabBarController = UITabBarController()
            
            mainViewController.tabBarItem = UITabBarItem(title: "First", image: UIImage(systemName: "house"), tag: 0)
            secondViewController.tabBarItem = UITabBarItem(title: "Second", image: UIImage(systemName: "star"), tag: 1)
            tabBarController.viewControllers = [navigationController,navigationController2]
            
            tabBarController.tabBar.backgroundColor = UIColor.white
            tabBarController.tabBar.layer.shadowColor = UIColor.black.cgColor
            tabBarController.tabBar.layer.shadowOpacity = 0.3
            tabBarController.tabBar.layer.shadowOffset = CGSize(width: 0, height: -3)
            tabBarController.tabBar.layer.shadowRadius = 5
            tabBarController.tabBar.layer.masksToBounds = false
            
            window?.rootViewController = tabBarController
            window?.makeKeyAndVisible()
        }

}

