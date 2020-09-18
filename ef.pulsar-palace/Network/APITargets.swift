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
    case signIn(user: UserSignIn)
    case signUp(user: User)
    case getUsersCharacters(userId:Int)
    case getUserByEmail(email: String)
    case updateUser(userId:Int, username:String, password: String, firstName: String, lastName: String, email: String)
    case getUser(userId:Int)
    case createEntry(entryText: String, promptId: Int, characterId: Int)
    case updateEntry(entryId: Int, entryText: String, promptId: Int, characterId: Int, userId: Int)
    case deleteEntry(entryId: Int, characterId: Int, userId: Int)
    case entryByCharacter(characterId: Int)
    case getEntry(entryId:Int)
    case createCharacter(userId: Int, name: String, additionalBio: String, characterSettingId: Int, characterBackgroundId: Int, characterRoleId: Int, characterDescriptorId: Int, currentHealth: Int, maxHealth: Int, logId: Int, archived: Bool)
    case archiveCharacter(characterId: Int, logId: Int)
    case updateCharacter(characterId:Int, userId: Int, name: String, additionalBio: String, characterSettingId: Int, characterBackgroundId: Int, characterRoleId: Int, characterDescriptorId: Int, currentHealth: Int, maxHealth: Int, logId: Int, archived: Bool)
    case deleteCharacter(characterId: Int, userId: Int)
    case getPlayerCharacterInfo
    case getCharacter(characterId: Int)
    case invitePlayerToLog(logId: Int, email: String)
    case getLog(logId: Int)
    case createLog(title: String)
    case updateLog(logId: Int, title:String)
    case getPrompt(lastEntryId: Int)
}

extension APITargets: TargetType, AccessTokenAuthorizable {
    var path: String {
        switch self {
        case .signIn:
            return "/users/login"
        case .signUp:
            return "/users/create"
        case .getUsersCharacters(let userId):
            return "users/\(userId)/characters.json"
        case .getUserByEmail(let email):
             return "get-user-by-email.json?email=\(email)"
        case .updateUser(let userId, _, _, _, _, _):
             return "users/\(userId).json"
        case .getUser(let userId):
             return "users/\(userId).json"
        case .createEntry(_, _, _):
             return "entries/create.json"
        case .updateEntry(let entryId, _, _, _, _):
             return "entries/\(entryId).json"
        case .deleteEntry(let entryId, _, _):
             return "entries/\(entryId).json"
        case .entryByCharacter(_):
            return "api/entries-for-character.json"
        case .getEntry(let entryId):
             return "entries/\(entryId).json"
        case .createCharacter(_,_,_,_,_,_,_,_,_,_,_):
             return "characters/create.json"
        case .archiveCharacter(let characterId,_):
             return "characters/\(characterId)/archive.json"
        case .updateCharacter(let characterId, _,_,_,_,_,_,_,_,_,_,_):
             return "characters/\(characterId).json"
        case .deleteCharacter(let characterId,_):
             return "characters/\(characterId).json"
        case .getPlayerCharacterInfo:
             return "player-character-info.json"
        case .getCharacter(let characterId):
             return "characters/\(characterId).json"
        case .invitePlayerToLog(let logId, let email):
             return "logs/\(logId)/invite.json?email=\(email)"
        case .getLog(let logId):
             return "logs/\(logId).json"
        case .createLog:
             return "logs/create.json"
        case .updateLog(let logId, _):
            return "logs/\(logId).json"
        case .getPrompt(let lastEntryId):
            return "prompts.json/?last_entry_id=\(lastEntryId)"
        }
    }
    
    var method: Moya.Method {
        switch self{
        case .signIn:
            return .post
        case .signUp:
            return .post
        case .getUsersCharacters:
            return .get
        case .getUserByEmail:
            return .get
        case .updateUser:
            return .put
        case .getUser:
            return .get
        case .createEntry:
            return .post
        case .updateEntry:
            return .put
        case .deleteEntry:
            return .delete
        case .getEntry:
            return .get
        case .entryByCharacter:
            return .get
        case .createCharacter:
            return .post
        case .archiveCharacter:
            return .post
        case .updateCharacter:
            return .put
        case .deleteCharacter:
            return .delete
        case .getPlayerCharacterInfo:
            return .get
        case .getCharacter:
            return .get
        case .invitePlayerToLog:
            return .get
        case .getLog:
            return .get
        case .createLog:
            return .post
        case .updateLog:
            return .put
        case .getPrompt:
            return .get
        }
    }
    
    
    var task: Task {
        switch self{
        case .signIn(let user):
            return .requestJSONEncodable(["user" : user])
        case .signUp(let user):
            return .requestJSONEncodable(["user" : user])
        case .getUsersCharacters(_):
            return .requestPlain
        case .getUserByEmail(email: let email):
            return .requestParameters(parameters: ["email": email], encoding: URLEncoding.default)
        case .updateUser(userId: let userId, username: let username, password: let password, firstName: let firstName, lastName: let lastName, email: let email):
            return .requestJSONEncodable([String(userId), username, password, firstName, lastName, email])
        case .getUser(_):
            return .requestPlain
        case .createEntry(entryText: let entryText, promptId: let promptId, characterId: let characterId):
            return .requestJSONEncodable([entryText, String(promptId), String(characterId)])
        case .updateEntry(entryId: let entryId, entryText: let entryText, promptId: let promptId, characterId: let characterId, userId: let userId):
            return .requestJSONEncodable([String(entryId), entryText, String(promptId), String(characterId), String(userId)])
        case .deleteEntry(entryId: let entryId, characterId: let characterId, userId: let userId):
            return .requestJSONEncodable([String(entryId), String(characterId), String(userId)])
        case .entryByCharacter(let characterId):
            return .requestParameters(parameters: ["character_id" : String(characterId)], encoding: URLEncoding.default)
        case .getEntry(_):
            return .requestPlain
        case .createCharacter(userId: let userId, name: let name, additionalBio: let additionalBio, characterSettingId: let characterSettingId, characterBackgroundId: let characterBackgroundId, characterRoleId: let characterRoleId, characterDescriptorId: let characterDescriptorId, currentHealth: let currentHealth, maxHealth: let maxHealth, logId: let logId, archived: let archived):
            return .requestJSONEncodable([String(userId), name, additionalBio, String(characterSettingId),
            String(characterBackgroundId), String(characterBackgroundId), String(characterRoleId), String(characterDescriptorId), String(currentHealth), String(maxHealth), String(logId), String(archived)])
        case .archiveCharacter(characterId: let characterId, logId: let logId):
            return .requestJSONEncodable([String(characterId), String(logId)])
        case .updateCharacter(characterId: let characterId, userId: let userId, name: let name, additionalBio: let additionalBio, characterSettingId: let characterSettingId, characterBackgroundId: let characterBackgroundId, characterRoleId: let characterRoleId, characterDescriptorId: let characterDescriptorId, currentHealth: let currentHealth, maxHealth: let maxHealth, logId: let logId, archived: let archived):
            return .requestJSONEncodable([String(characterId),String(userId), name, additionalBio, String(characterSettingId),String(characterBackgroundId), String(characterBackgroundId), String(characterRoleId), String(characterDescriptorId), String(currentHealth), String(maxHealth), String(logId), String(archived)])
        case .deleteCharacter(characterId: let characterId, userId: let userId):
            return .requestJSONEncodable([String(characterId), String(userId)])
        case .getPlayerCharacterInfo:
            return .requestPlain
        case .getCharacter:
            return .requestPlain
        case .invitePlayerToLog(_, email: let email):
            return .requestParameters(parameters: ["email": email], encoding: URLEncoding.default)
        case .getLog(_):
            return .requestPlain
        case .createLog(title: let title):
            return .requestJSONEncodable([title])
        case .updateLog(logId: let logId, title: let title):
            return .requestJSONEncodable([String(logId), title])
        case .getPrompt(lastEntryId: let lastEntryId):
            return .requestJSONEncodable([String(lastEntryId)])
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type" : "application/json"]
    }
    
    var baseURL: URL{
        return URL(string: "http://192.168.1.15:8081/api")!
    }
    var authorizationType: AuthorizationType? {
         switch self {
         case .signIn:
             return nil
         case .signUp:
             return nil
         case .getUsersCharacters:
             return .bearer
         case .getUserByEmail:
             return nil
         case .updateUser:
             return .bearer
         case .getUser:
             return .bearer
         case .createEntry:
             return .bearer
         case .updateEntry:
             return .bearer
         case .deleteEntry:
             return .bearer
         case .getEntry:
            return .bearer
         case .entryByCharacter:
             return nil
         case .createCharacter:
            return .bearer
         case .archiveCharacter:
            return .bearer
         case .updateCharacter:
             return .bearer
         case .deleteCharacter:
             return .bearer
         case .getPlayerCharacterInfo:
             return nil
         case .getCharacter:
             return .bearer
         case .invitePlayerToLog:
             return .bearer
         case .getLog:
            return .bearer
         case .createLog:
             return .bearer
         case .updateLog:
             return .bearer
         case .getPrompt:
             return nil
         }
    }
}
