//
//  UserDefaultExtensions.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 9/1/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import Foundation

extension UserDefaults {
    static func contains(_ key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}

extension UserDefaults{
    public struct Keys{
        static let token = "Token"
        static let currentUserId = "CurrentUserId"
        static let isLoggedIn = "IsLoggedIn"
    }
}
