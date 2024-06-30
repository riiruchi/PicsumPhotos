//
//  AppDelegate.swift
//  PicsumPhotos
//
//  Created by Ruchira  on 30/06/24.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    // For iOS 13 and later
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
            return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // This function is required by the protocol but does not need any implementation for basic usage.
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 13.0, *) {
            // The window will be configured in the SceneDelegate for iOS 13 and later
        } else {
            window = UIWindow(frame: UIScreen.main.bounds)
            let viewController = HomeViewController()
            window?.rootViewController = viewController
            window?.makeKeyAndVisible()
        }
        return true
    }
}

