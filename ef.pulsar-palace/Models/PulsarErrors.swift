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
    case lostUser
    case unableToSetToken
    case unknownKey
    case tagUserMismatch
    case musicPlayerSessionError
    case musicPlayerPlaybackError
}

extension PulsarError: LocalizedError {
    public var errorDescription: String?{
        switch self {
        case .invalidEmail:
            return NSLocalizedString("Invalid Email Address", comment: "PulsarError-invalidEmail.errorDescription")
        case .mismatchedPassword:
            return NSLocalizedString("Passwords don't match", comment: "PulsarError-mismatchedPassword.errorDescription")
        case .parsingError:
            return NSLocalizedString("Parsing Problems", comment: "PulsarError-parsingError.errorDescription")
        case .connectionError:
            return NSLocalizedString("Connection Error", comment: "PulsarError-connectionError.errorDescription")
        case .invalidCredentials:
            return NSLocalizedString("Invalid Credentials", comment: "PulsarError-invalidCredentials.errorDescription")
        case .lostUser:
            return NSLocalizedString("Lost User", comment: "PulsarError-lostUser.errorDescription")
        case .unableToSetToken:
            return NSLocalizedString("Can't Set Token.", comment: "PulsarError-unableToSetToken.errorDescription")
        case .unknownKey:
            return NSLocalizedString("Unknown Key", comment: "PulsarError-unknownKey.errorDescription")
        case .tagUserMismatch:
            return  NSLocalizedString("Tag / Account Mismatch", comment: "PulsarError-tagUserMismatch.errorDescription")
        case .musicPlayerSessionError:
            return NSLocalizedString("Playback Session", comment: "PulsarError-musicPlayerSessionError.errorDescription")
        case .musicPlayerPlaybackError:
            return NSLocalizedString("Playback Error", comment: "PulsarError-musicPlayerPlaybackError.errorDescription")
        }
    }
    public var failureReason: String?{
        switch self {
        case .invalidEmail:
            return NSLocalizedString("Email address doesn't look right.", comment: "PulsarError-invalidEmail.failureReason")
        case .mismatchedPassword:
            return NSLocalizedString("The confirm password field doesn't match your password field", comment: "PulsarError-mismatchedPassword.failureReason")
        case .parsingError:
            return NSLocalizedString("The data, either from the server or local storage is unparsable", comment: "PulsarError-parsingError.failureReason")
        case .connectionError:
            return NSLocalizedString("Can't reach the server. Maybe it's down?", comment: "PulsarError-connectionError.failureReason")
        case .invalidCredentials:
            return NSLocalizedString("The email and password entered doesn't match any accounts", comment: "PulsarError-invalidCredentials.failureReason")
        case .lostUser:
            return NSLocalizedString("For some odd reason, the user id we store on your phone isn't there.", comment: "PulsarError-lostUser.failureReason")
        case .unableToSetToken:
            return NSLocalizedString("The token required to connect with the service can not be set.", comment: "PulsarError-unableToSetToken.failureReason")
        case .unknownKey:
            return NSLocalizedString("Tried to retrieve a local value with an unknown key.", comment: "PulsarError-unknownKey.failureReason")
        case .tagUserMismatch:
            return  NSLocalizedString("The tag you're scanning doesn't match the account you're using.", comment: "PulsarError-tagUserMismatch.failureReason")
        case .musicPlayerSessionError:
            return NSLocalizedString("The session for the music player was interrupted.", comment: "PulsarError-musicPlayerSessionError.failureReason")
        case .musicPlayerPlaybackError:
            return NSLocalizedString("The playback was interupted,", comment: "PulsarError-musicPlayerPlaybackError.failureReason")
        }
    }
    public var recoverySuggestion: String?{
        switch self {
        case .invalidEmail:
            return NSLocalizedString("Try re-entering your email address with the name@domain.tld format", comment: "PulsarError-invalidEmail.recoverySuggestion")
        case .mismatchedPassword:
            return NSLocalizedString("Try re-entering the password and confirmation", comment: "PulsarError-mismatchedPassword.recoverySuggestion")
        case .parsingError:
            return NSLocalizedString("This is Gabe's fault. There's not you can do. Sorry.", comment: "PulsarError-parsingError.recoverySuggestion")
        case .connectionError:
            return NSLocalizedString("Check your network connection is working.", comment: "PulsarError-connectionError.recoverySuggestion")
        case .invalidCredentials:
            return NSLocalizedString("Try re-entering your email and password.", comment: "PulsarError-invalidCredentials.recoverySuggestion")
        case .lostUser:
            return NSLocalizedString("Sign out and sign in again.", comment: "PulsarError-lostUser.recoverySuggestion")
        case .unableToSetToken:
            return NSLocalizedString("Sign out and sign in again", comment: "PulsarError-unableToSetToken.recoverySuggestion")
        case .unknownKey:
            return NSLocalizedString("This is Gabe's fault. There's not you can do. Sorry.", comment: "PulsarError-unknownKey.recoverySuggestion")
        case .tagUserMismatch:
            return  NSLocalizedString("Try logging out and in again. Maybe you switched a card with one of the other 2 Earthly Frames fans?", comment: "PulsarError-tagUserMismatch.recoverySuggestion")
        case .musicPlayerSessionError:
            return NSLocalizedString("This is Gabe's fault. There's not you can do. Sorry.", comment: "PulsarError-musicPlayerSessionError.recoverySuggestion")
        case .musicPlayerPlaybackError:
            return NSLocalizedString("Try loading this encounter again.", comment: "PulsarError-musicPlayerPlaybackError.recoverySuggestion")
        }
    }
}

