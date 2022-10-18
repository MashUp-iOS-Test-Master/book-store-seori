//
//  SceneDelegate.swift
//  BookStore
//
//  Created by Seori on 2022/10/18.
//

import UIKit

final class SceneDelegate: UIResponder,
                           UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        
        let rootViewController = ViewController()
        self.window?.rootViewController = rootViewController
        self.window?.makeKeyAndVisible()
    }
}

