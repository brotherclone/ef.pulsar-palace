//
//  APITargets.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 8/26/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import Foundation
import Moya

enum APITargets {
    case getPlayerCharacterData
    case checkTag(uuid:String)
    case newCharacter(character: CharacterPost)
}

extension APITargets: TargetType {
    var path: String {
        switch self {
        case .getPlayerCharacterData:
            return "player-characters.json"
        case .checkTag:
            return "check-tag.json"
        case .newCharacter:
            return "characters/create.json"
        }
    }
    
    var method: Moya.Method {
        switch self{
        case .getPlayerCharacterData:
            return .get
        case .checkTag:
            return .post
        case .newCharacter:
            return .post
        }
    }
    
    
    var task: Task {
        switch self{
        case .getPlayerCharacterData:
            return .requestPlain
        case .checkTag(let uuid):
            return .requestParameters(parameters: ["uuid": uuid], encoding: URLEncoding.queryString)
        case .newCharacter(let character):
            return .requestJSONEncodable(character)
            
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type" : "application/json"]
    }
    
    var baseURL: URL{
        return URL(string: "http://192.168.1.15:8081/")!
    }
}
