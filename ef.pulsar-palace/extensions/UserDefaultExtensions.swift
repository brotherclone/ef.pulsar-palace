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
