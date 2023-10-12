//
//  MainCoordinator.swift
//  LegheFantaChallenge
//
//  Created by Alessandro Di Majo on 12/10/23.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var coordinators: [Coordinator] = []

    // MARK: - Architecture properties
    private var navigator: UINavigationController
    private let window: UIWindow
    fileprivate let tabBarController = UITabBarController()

    init(window: UIWindow) {
        navigator = UINavigationController(rootViewController: tabBarController)
        self.window = window
    }

    func start() {
        print("MainCoordinator start")
        
        let firstVC = UIViewController()
        firstVC.view.backgroundColor = .white
        let secondVC = UIViewController()
        secondVC.view.backgroundColor = .white
        tabBarController.viewControllers = [
            firstVC,
            secondVC
        ]
        tabBarController.tabBar.tintColor = .blue
        tabBarController.tabBar.backgroundColor = .systemGray2
        tabBarController.tabBar.backgroundImage = UIImage()
        tabBarController.tabBar.shadowImage = UIImage()
        window.switchRootViewController(to: tabBarController)
    }
}
