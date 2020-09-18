//
//  AuthenticationHelper.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 9/11/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import Foundation

class AuthenticationHelper: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var token: String? = nil
}
