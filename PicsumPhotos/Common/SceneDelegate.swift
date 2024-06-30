//
//  SceneDelegate.swift
//  PicsumPhotos
//
//  Created by Ruchira  on 30/06/24.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }

        // Set the initial view controller from LaunchScreen storyboard
        if let launchScreenVC = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController() {
            window?.rootViewController = launchScreenVC
            window?.makeKeyAndVisible()

            // Navigate to MainViewController after 5 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.navigateToMainViewController()
            }
        }
    }
    
    func navigateToMainViewController() {
        // Instantiate the main view controller
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            if let mainViewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
            // Set it as the root view controller
            window?.rootViewController = mainViewController
            window?.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }
}
