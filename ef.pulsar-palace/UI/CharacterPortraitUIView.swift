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
    var body: some View {
        ZStack{
            // MARK: Setting
            WebImage(url: URL(string: "https://res.cloudinary.com/hobvqx95l/image/upload/v1605015454/Pulsar%20Palace/Character%20Art/character__0014_setting-nyc.png"))
                // Supports options and context, like `.delayPlaceholder` to show placeholder only when error
                .onSuccess { image, data, cacheType in
                    // Success
                    // Note: Data exist only when queried from disk cache or network. Use `.queryMemoryData` if you really need data
                }
                .resizable() // Resizable like SwiftUI.Image, you must use this modifier or the view will use the image bitmap size
                .placeholder(Image(systemName: "temp")) // Placeholder Image
                // Supports ViewBuilder as well
                .placeholder {
                    Rectangle().foregroundColor(.gray)
                }
                .indicator(.activity) // Activity Indicator
                .transition(.fade(duration: 0.5)) // Fade Transition with duration
                .scaledToFit()
                .frame(width: 300, height: 300, alignment: .center)
            // MARK: Role
            WebImage(url: URL(string: "https://res.cloudinary.com/hobvqx95l/image/upload/v1605015456/Pulsar%20Palace/Character%20Art/character__0010_role-doctor.png"))
                // Supports options and context, like `.delayPlaceholder` to show placeholder only when error
                .onSuccess { image, data, cacheType in
                    // Success
                    // Note: Data exist only when queried from disk cache or network. Use `.queryMemoryData` if you really need data
                }
                .resizable() // Resizable like SwiftUI.Image, you must use this modifier or the view will use the image bitmap size
                .placeholder(Image(systemName: "temp")) // Placeholder Image
                // Supports ViewBuilder as well
                .placeholder {
                    Rectangle().foregroundColor(.gray)
                }
                .indicator(.activity) // Activity Indicator
                .transition(.fade(duration: 0.5)) // Fade Transition with duration
                .scaledToFit()
                .frame(width: 300, height: 300, alignment: .center)
            
            // MARK: Descriptor
            WebImage(url: URL(string: "https://res.cloudinary.com/hobvqx95l/image/upload/v1605015456/Pulsar%20Palace/Character%20Art/character__0009_descriptor-crazed.png"))
                // Supports options and context, like `.delayPlaceholder` to show placeholder only when error
                .onSuccess { image, data, cacheType in
                    // Success
                    // Note: Data exist only when queried from disk cache or network. Use `.queryMemoryData` if you really need data
                }
                .resizable() // Resizable like SwiftUI.Image, you must use this modifier or the view will use the image bitmap size
                .placeholder(Image(systemName: "temp")) // Placeholder Image
                // Supports ViewBuilder as well
                .placeholder {
                    Rectangle().foregroundColor(.gray)
                }
                .indicator(.activity) // Activity Indicator
                .transition(.fade(duration: 0.5)) // Fade Transition with duration
                .scaledToFit()
                .frame(width: 300, height: 300, alignment: .center)
        }
        
    }
}

struct CharacterPortraitUIView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterPortraitUIView()
    }
}
