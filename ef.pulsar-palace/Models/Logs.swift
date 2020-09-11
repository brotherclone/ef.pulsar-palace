//
//  Logs.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 8/28/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import Foundation

public struct Log {
    var id: Int
    var title: String
}

extension Log: Encodable, Decodable {

    enum LogKeys: String, CodingKey{
        case id
        case title
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: LogKeys.self)
        _ = try container.decode(Log.self, forKey: .id)
        id = try container.decode(Int.self, forKey: .id)
        _ = try container.decode(Log.self, forKey: .title)
        title = try container.decode(String.self, forKey: .title)
    
    }
}
