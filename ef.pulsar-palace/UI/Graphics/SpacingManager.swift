//
//  SpacingManager.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 11/10/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import Foundation
import UIKit

let oddPace: CGFloat = 16.0
let evenPace: CGFloat = 20.0

enum SpacingManager{
    case barely
    case oddOne
    case oddTwo
    case oddThree
    case evenOne
    case evenTwo
    case evenThree
}

extension SpacingManager{
    var space: CGFloat{
        switch self{
        case .barely:
            return 1.0
        case .oddOne:
            return oddPace
        case .oddTwo:
            return oddPace * 2.0
        case .oddThree:
            return oddPace * 3.0
        case .evenOne:
            return evenPace
        case .evenTwo:
            return evenPace * 2.0
        case .evenThree:
            return evenPace * 3.0
        }
    }
}
