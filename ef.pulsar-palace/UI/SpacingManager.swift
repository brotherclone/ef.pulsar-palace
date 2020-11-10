//
//  SpacingManager.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 11/10/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import Foundation
import UIKit

enum SpacingManager{
    case edge
    case verticalPace
    case barely
}

extension SpacingManager{
    var space: CGFloat{
        switch self{
        case .edge:
            return 16.0
        case .verticalPace:
            return 32.0
        case .barely:
            return 1.0
        }
    }
}
