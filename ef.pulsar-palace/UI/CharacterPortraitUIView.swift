//
//  CharacterPortraitUIView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 11/10/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharacterPortraitUIView: View {
    
    var descriptor: CharacterDescriptor
    var role: CharacterRole
    var setting: CharacterSetting
    var height: CGFloat
    var width: CGFloat
    
    var body: some View {
        ZStack{
            // MARK: Setting
            WebImage(url: URL(string: setting.imageURL))
                .resizable()
                .placeholder {
                    Rectangle().foregroundColor(.blue)
                }
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFit()
                .frame(width: width, height: height, alignment: .center)
            // MARK: Role
            WebImage(url: URL(string: role.imageURL))
                .resizable()
                .placeholder {
                    Rectangle().foregroundColor(.blue)
                }
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFit()
                .frame(width: width, height: height, alignment: .center)
            // MARK: Descriptor
            WebImage(url: URL(string: descriptor.imageURL))
                .resizable()
                .placeholder {
                    Rectangle().foregroundColor(.blue)
                }
                .indicator(.activity) // Activity Indicator
                .transition(.fade(duration: 0.5)) // Fade Transition with duration
                .scaledToFit()
                .frame(width: width, height: height, alignment: .center)
        }
    }
}
