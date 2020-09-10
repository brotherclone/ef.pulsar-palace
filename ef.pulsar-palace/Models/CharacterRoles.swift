//
//  CharacterRoles.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 8/28/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import Foundation

public struct CharacterRole {
    var id: Int
    var character_role: String
}

extension CharacterRole: Decodable {
    
    enum CharacterRoleKeys: String, CodingKey{
        case id
        case character_role
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CharacterRoleKeys.self)
        _ = try container.decode(CharacterRole.self, forKey: .id)
        id = try container.decode(Int.self, forKey: .id)
        _ = try container.decode(CharacterRole.self, forKey: .character_role)
        character_role = try container.decode(String.self, forKey: .character_role)
    }
}
