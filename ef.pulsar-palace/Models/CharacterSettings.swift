//
//  CharacterSettings.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 8/28/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import Foundation

public struct CharacterSetting {
    var id: Int
    var place: String
    var time: String
    var imageURL: String
}

extension CharacterSetting: Encodable, Decodable {
    
    enum CharacterSettingKeys: String, CodingKey{
        case id
        case place
        case time
        case imageURL
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CharacterSettingKeys.self)
        _ = try container.decode(CharacterSetting.self, forKey: .id)
        id = try container.decode(Int.self, forKey: .id)
        _ = try container.decode(CharacterSetting.self, forKey: .place)
        place = try container.decode(String.self, forKey: .place)
        _ = try container.decode(CharacterSetting.self, forKey: .time)
        time = try container.decode(String.self, forKey: .time)
        _ = try container.decode(CharacterSetting.self, forKey: .imageURL)
        imageURL = try container.decode(String.self, forKey: .imageURL)
        
    }
}
