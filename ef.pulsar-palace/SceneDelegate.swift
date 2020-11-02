//
//  SceneDelegate.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 8/17/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        for fontFamily in UIFont.familyNames {
//            print("Using fonts:")
//            for fontName in UIFont.fontNames(forFamilyName: fontFamily) {
//                print("\(fontName)")
//            }
//        }
        let contentView = StartView()
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
