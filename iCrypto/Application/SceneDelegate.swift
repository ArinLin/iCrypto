//
//  SceneDelegate.swift
//  iCrypto
//
//  Created by Arina on 24.07.2023.
//

import UIKit
import SDWebImage

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow (windowScene: windowScene)
        window.rootViewController = UINavigationController(rootViewController: HomeController())
        self.window = window
        self.window?.makeKeyAndVisible()
        
        print("DEBUG PRINT:", SDImageCache.shared.diskCache.totalSize())

        SDImageCache.shared.config.maxDiskSize = 1000000 * 20
    }
}

