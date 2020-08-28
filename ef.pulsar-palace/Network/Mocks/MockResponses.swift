//
//  MockResponses.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 8/26/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import Foundation
import Moya

func stubbedResponse(_ fileName: String) -> Data{
    @objc class Spec: NSObject {}
    let factory = Bundle(for: Spec.self)
    let path = factory.path(forResource: fileName, ofType: "json")
    return (try! Data.init(contentsOf: URL(fileURLWithPath: path!)))
}

extension APITargets{
    var sampleData: Data{
        switch self {
        case .getPlayerCharacterData:
            return stubbedResponse("playerCharacterData")
        }
    }
}
