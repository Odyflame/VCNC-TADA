//
//  AppDelegate.swift
//  TADA_HomeWork
//
//  Created by apple on 2021/05/26.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.main.bounds)

        self.window?.rootViewController = ChooseOptionViewController()
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

