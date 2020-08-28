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
}

extension APITargets: TargetType {
    var path: String {
         switch self {
         case .getPlayerCharacterData:
            return "player-characters.json"
        }
    }
    
    var method: Moya.Method {
        switch self{
        case .getPlayerCharacterData:
            return .get
        }
    }
    
    
    var task: Task {
        switch self{
        case .getPlayerCharacterData:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
         return ["Content-type" : "application/json"]
    }
    
    var baseURL: URL{
        return URL(string: "http://192.168.1.15:8081/")!
    }
}
