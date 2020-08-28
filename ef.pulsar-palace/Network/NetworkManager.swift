//
//  NetworkManager.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 8/26/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import Foundation
import Moya

struct NetworkManager{
    static let provider = MoyaProvider<APITargets>(plugins:[NetworkLoggerPlugin()])
}
