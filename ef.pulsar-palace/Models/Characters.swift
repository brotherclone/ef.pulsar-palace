//
//  Characters.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 8/28/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import Foundation

public struct Character {
    var id: Int?
    var user: User
    var name: String
    var additionalBio: String?
    var characterBackground: CharacterBackground
    var characterSetting: CharacterSetting
    var characterRole: CharacterRole
    var characterDescriptor: CharacterDescriptor
    var currentHealth: Int
    var maxHealth: Int
    var log: Log
    var archived: Bool
    
}


extension Character: Decodable {
    
    enum CharacterKeys: String, CodingKey{
        case id
        case user
        case name
        case additionalBio
        case characterBackground
        case characterSetting
        case characterRole
        case characterDescriptor
        case currentHealth
        case maxHealth
        case log
        case archived
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CharacterKeys.self)
        _ = try container.decode(Character.self, forKey: .id)
        id = try container.decode(Int.self, forKey: .id)
        _ = try container.decode(Character.self, forKey: .user)
        user = try container.decode(User.self, forKey: .user)
        _ = try container.decode(Character.self, forKey: .name)
        name = try container.decode(String.self, forKey: .name)
        _ = try container.decode(Character.self, forKey: .additionalBio)
        additionalBio = try container.decode(String.self, forKey: .additionalBio)
        _ = try container.decode(Character.self, forKey: .characterBackground)
        characterBackground = try container.decode(CharacterBackground.self, forKey: .characterBackground)
        _ = try container.decode(Character.self, forKey: .characterSetting)
        characterSetting = try container.decode(CharacterSetting.self, forKey: .characterSetting)
        _ = try container.decode(Character.self, forKey: .characterRole)
        characterRole = try container.decode(CharacterRole.self, forKey: .characterRole)
        _ = try container.decode(Character.self, forKey: .characterDescriptor)
        characterDescriptor = try container.decode(CharacterDescriptor.self, forKey: .characterDescriptor)
        _ = try container.decode(Character.self, forKey: .currentHealth)
        currentHealth = try container.decode(Int.self, forKey: .currentHealth)
        _ = try container.decode(Character.self, forKey: .maxHealth)
        maxHealth = try container.decode(Int.self, forKey: .maxHealth)
        _ = try container.decode(Character.self, forKey: .log)
        log = try container.decode(Log.self, forKey: .log)
        _ = try container.decode(Character.self, forKey: .archived)
        archived = try container.decode(Bool.self, forKey: .archived)
    }
}

public struct CharacterPost: Codable {
    private enum CodingKeys: String, CodingKey{
        case name = "name"
        case userId = "user_id"
        case additionalBio = "additional_bio"
        case characterBackgroundId = "character_background_id"
        case characterSettingId = "character_setting_id"
        case characterRoleId = "character_role_id"
        case characterDescriptorId = "character_descriptor_id"
        case currentHealth = "current_health"
        case maxHealth = "max_health"
        case logId = "log_id"
        case archived = "archived"
    }
    
    let name: String
    let userId: Int
    let additionalBio: String
    let characterBackgroundId: Int
    let characterSettingId: Int
    let characterRoleId: Int
    let characterDescriptorId: Int
    let currentHealth: Int
    let maxHealth: Int
    let logId: Int
    let archived: Bool
    
}


extension CharacterPost {
    init(character:Character) {
        self.init(name: character.name,
                  userId: character.user.id,
                  additionalBio: character.additionalBio!,
                  characterBackgroundId: character.characterBackground.id,
                  characterSettingId: character.characterSetting.id,
                  characterRoleId: character.characterRole.id,
                  characterDescriptorId: character.characterDescriptor.id,
                  currentHealth: character.currentHealth,
                  maxHealth: character.maxHealth,
                  logId: character.log.id,
                  archived: character.archived)
    }
}
