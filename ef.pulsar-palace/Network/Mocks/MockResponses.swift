//
//  MockResponses.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 8/26/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import Foundation
import Moya

func stubbedResponse(_ fileName: String) -> Data{
    @objc class Spec: NSObject {}
    let factory = Bundle(for: Spec.self)
    let path = factory.path(forResource: fileName, ofType: "json")
    return (try! Data.init(contentsOf: URL(fileURLWithPath: path!)))
}

extension APITargets{
    var sampleData: Data{
        switch self {
        case .signIn:
            return stubbedResponse("signIn")
        case .signUp:
            return stubbedResponse("signUp")
        case .getUsersCharacters:
            return stubbedResponse("getUserCharacters")
        case .getUserByEmail:
            return stubbedResponse("getUserByEmail")
        case .updateUser:
            return stubbedResponse("updateUser")
        case .getUser:
            return stubbedResponse("getUser")
        case .createEntry:
            return stubbedResponse("createEntry")
        case .updateEntry:
            return stubbedResponse("updateEntry")
        case .deleteEntry:
            return stubbedResponse("deleteEntry")
        case .getEntry:
            return stubbedResponse("getEntry")
        case .createCharacter:
            return stubbedResponse("createCharacter")
        case .archiveCharacter:
            return stubbedResponse("archiveCharacter")
        case .updateCharacter:
            return stubbedResponse("updateCharacter")
        case .deleteCharacter:
            return stubbedResponse("deleteCharacter")
        case .getPlayerCharacterInfo:
            return stubbedResponse("getPlayerCharacterInfo")
        case .getCharacter:
            return stubbedResponse("getCharacter")
        case .invitePlayerToLog:
            return stubbedResponse("invitePlayerToLog")
        case .getLog:
            return stubbedResponse("getLog")
        case .createLog:
            return stubbedResponse("createLog")
        case .updateLog:
            return stubbedResponse("updateLog")
        case .getPrompt:
            return stubbedResponse("getPrompt")
        case .entryByCharacter:
            return stubbedResponse("entriesByCharacter")
        }
    }
}
