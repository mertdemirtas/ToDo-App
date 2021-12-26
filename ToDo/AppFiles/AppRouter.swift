//
//  appRouter.swift
//  ToDo
//
//  Created by Mert Demirtaş on 12.12.2021.
//

import Foundation
import UIKit

class AppRouter {
    
    func start(scene: UIWindowScene) -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: ListBuilder.build())
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        window.windowScene = scene
        return window
    }
}
