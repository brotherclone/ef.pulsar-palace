//
//  PulsarErrors.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 9/29/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import Foundation

enum PulsarError: Error {
    case invalidEmail
    case mismatchedPassword
    case parsingError
    case connectionError
    case invalidCredentials
}


extension PulsarError: LocalizedError {
    public var errorDescription: String?{
        switch self {
        case .invalidEmail:
            return NSLocalizedString("So, like email addresses are like something something @ something . something", comment: "Invalid Email")
        case .mismatchedPassword:
            return NSLocalizedString("Careful now, the password and password confirmation do not match.", comment: "Mismatched Passwords")
        case .parsingError:
            return NSLocalizedString("I messed up. I can't make sense of what I'm hearing. My bad.", comment: "Parsing Error")
        case .connectionError:
            return NSLocalizedString("Calling earthlyframes.com... Hello?", comment: "Connection Error")
        case .invalidCredentials:
            return NSLocalizedString("Wanna try that email and password again? I don't recognize them.", comment: "Invalid Credentials")
        }
    }
}
