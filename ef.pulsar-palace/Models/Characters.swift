//
//  Characters.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 8/28/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct Character {
    var id: Int?
    var user_id: Int
    var name: String
    var additional_bio: String?
    var character_background_id: Int
    var characterBackground: CharacterBackground?
    var character_setting_id: Int
    var characterSetting: CharacterSetting?
    var character_role_id: Int
    var characterRole: CharacterRole?
    var character_descriptor_id: Int
    var characterDescriptor: CharacterDescriptor?
    var current_health: Int
    var max_health: Int
    var log_id: Int?
    var archived: Bool
    
}


extension Character: Decodable, Encodable {
    
    enum CharacterKeys: String, CodingKey{
        case id
        case user_id
        case name
        case additional_bio
        case character_background_id
        case characterBackground
        case character_setting_id
        case characterSetting
        case character_role_id
        case characterRole
        case character_descriptor_id
        case characterDescriptor
        case current_health
        case max_health
        case log_id
        case archived
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CharacterKeys.self)
        
        _ = try container.decode(Character.self, forKey: .id)
        id = try container.decode(Int.self, forKey: .id)
        
        _ = try container.decode(Character.self, forKey: .user_id)
        user_id = try container.decode(Int.self, forKey: .user_id)
        
        _ = try container.decode(Character.self, forKey: .name)
        name = try container.decode(String.self, forKey: .name)
        
        _ = try container.decode(Character.self, forKey: .additional_bio)
        additional_bio = try container.decode(String.self, forKey: .additional_bio)
        
        _ = try container.decode(Character.self, forKey: .character_background_id)
        character_background_id = try container.decode(Int.self, forKey: .character_background_id)
        
        _ = try container.decode(Character.self, forKey: .characterBackground)
        characterBackground = try container.decode(CharacterBackground.self, forKey: .characterBackground)
        
        _ = try container.decode(Character.self, forKey: .character_setting_id)
        character_setting_id = try container.decode(Int.self, forKey: .character_setting_id)
        
        _ = try container.decode(Character.self, forKey: .characterSetting)
        characterSetting = try container.decode(CharacterSetting.self, forKey: .characterSetting)
        
        _ = try container.decode(Character.self, forKey: .character_role_id)
        character_role_id = try container.decode(Int.self, forKey: .character_role_id)
        
        _ = try container.decode(Character.self, forKey: .characterRole)
        characterRole = try container.decode(CharacterRole.self, forKey: .characterRole)
        
        _ = try container.decode(Character.self, forKey: .character_descriptor_id)
        character_descriptor_id = try container.decode(Int.self, forKey: .character_descriptor_id)
        
        _ = try container.decode(Character.self, forKey: .characterDescriptor)
        characterDescriptor = try container.decode(CharacterDescriptor.self, forKey: .characterDescriptor)
        
        _ = try container.decode(Character.self, forKey: .current_health)
        current_health = try container.decode(Int.self, forKey: .current_health)
        
        _ = try container.decode(Character.self, forKey: .max_health)
        max_health = try container.decode(Int.self, forKey: .max_health)
        
        _ = try container.decode(Character.self, forKey: .log_id)
        log_id = try container.decode(Int.self, forKey: .log_id)
        
        _ = try container.decode(Character.self, forKey: .archived)
        archived = try container.decode(Bool.self, forKey: .archived)
    }
}


