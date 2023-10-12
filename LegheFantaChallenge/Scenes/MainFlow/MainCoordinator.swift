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
    fileprivate let tabBarController = LegheFantaChallengeTabBarController()

    init(window: UIWindow) {
        navigator = UINavigationController(rootViewController: tabBarController)
        self.window = window
    }

    func start() {
        print("MainCoordinator start")
        
        let firstVC = PlayersViewController(viewModel: .init())
        firstVC.tabBarItem = UITabBarItem(
            title: "Lista calciatori",
            image: UIImage(systemName: "person.fill"),
            selectedImage: UIImage(systemName: "person.fill")?.withTintColor(Colors.blue)
        )
        
        let secondVC = FavouritePlayersViewController(viewModel: .init())
        secondVC.tabBarItem = UITabBarItem(
            title: "Preferiti",
            image: UIImage(systemName: "star.fill"),
            selectedImage: UIImage(systemName: "star.fill")?.withTintColor(Colors.blue)
        )

        tabBarController.viewControllers = [
            firstVC,
            secondVC
        ]
       
        _ = firstVC.view
        _ = secondVC.view
        
        window.switchRootViewController(to: navigator)
    }
}
