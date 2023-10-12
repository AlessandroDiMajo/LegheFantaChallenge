//
//  LegheFantaChallengeTabBarController.swift
//  LegheFantaChallenge
//
//  Created by Alessandro Di Majo on 12/10/23.
//

import UIKit

class LegheFantaChallengeTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = Colors.blue
        tabBar.backgroundColor = Colors.gray
        tabBar.isOpaque = true
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
