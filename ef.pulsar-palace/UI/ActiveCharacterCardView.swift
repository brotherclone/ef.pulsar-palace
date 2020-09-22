//
//  ActiveCharacterCardView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 9/22/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI

struct ActiveCharacterCardView: View {
    
    var character: Character?
    
    var body: some View {
        if character != nil{
            Text(character!.name)
        }
    }
}

//struct ActiveCharacterCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        ActiveCharacterCardView()
//    }
//}

// MARK: Show preview with mocks
