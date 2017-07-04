//
//  AppDelegate.swift
//  Random1
//
//  Created by Sebastian Maschner on 21/03/2017.
//
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        
        let programsViewController = ProgramsViewController()
        let programsNavigationController = NavigationController(rootViewController: programsViewController)
        
        let downloadsViewController = DownloadsViewController()
        let downloadsNavigationController = NavigationController(rootViewController: downloadsViewController)
        
        programsNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.bookmarks, tag: 1)
        downloadsNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.downloads, tag: 2)
        
        let tabController = TabBarController(tabs: [programsNavigationController, downloadsNavigationController])
        
        window?.rootViewController = tabController
        window?.makeKeyAndVisible()
        
        return true
    }
}

