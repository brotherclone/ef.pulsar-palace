//
//  Prompts.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 8/28/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import Foundation

public struct Prompt {
    var id: Int
    var song: Song
    var encounter_type: Int
    var prompt_title: String
    var prompt_text: String
    var prompt_image: URL
    var damage: Int
}

extension Prompt: Decodable {
    
    enum PromptKeys: String, CodingKey{
        case id
        case song
        case encounter_type
        case prompt_title
        case prompt_text
        case prompt_image
        case damage
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PromptKeys.self)
        _ = try container.decode(Prompt.self, forKey: .id)
        id = try container.decode(Int.self, forKey: .id)

        _ = try container.decode(Prompt.self, forKey: .song)
        song = try container.decode(Song.self, forKey: .song)

        _ = try container.decode(Prompt.self, forKey: .encounter_type)
        encounter_type = try container.decode(Int.self, forKey: .encounter_type)

        _ = try container.decode(Prompt.self, forKey: .prompt_title)
        prompt_title = try container.decode(String.self, forKey: .prompt_title)

        _ = try container.decode(Prompt.self, forKey: .prompt_text)
        prompt_text = try container.decode(String.self, forKey: .prompt_text)

        _ = try container.decode(Prompt.self, forKey: .prompt_image)
        prompt_image = try container.decode(URL.self, forKey: .prompt_image)

        _ = try container.decode(Prompt.self, forKey: .damage)
        damage = try container.decode(Int.self, forKey: .damage)
        
    }
}
