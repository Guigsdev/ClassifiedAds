//
//  SceneDelegate.swift
//  ClassifiedAds
//
//  Created by Guillaume-Webwag on 19/07/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        window = UIWindow()
        window?.windowScene = scene as? UIWindowScene

        let navController = UINavigationController()
        setupNavigationBarAppearance()
        let coordinator = MainCoordinator(navigationController: navController)
        coordinator.start()

        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }

    fileprivate func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .orange
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().tintColor = .white
    }

}

