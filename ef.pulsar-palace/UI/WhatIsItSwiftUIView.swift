//
//  WhatIsItSwiftUIView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 11/10/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI

struct WhatIsItSwiftUIView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack{
            Color.yellow
                .ignoresSafeArea()
            Group{
                VStack(spacing: SpacingManager.verticalPace.space){
                    Spacer()
                    Text("What is it?").pulsarFont(style: .h1).foregroundColor(.black)
                    Text("Pulsar Palace is a single-player role-playing game in which you explore an extra-dimensional setting. You play by authoring entries in a log that document each room you encounter in the Pulsar Palace. This place is unforgiving, and your character is likely to perish. When this happens, you can create another character, try again, or send your journey with a friend. You'll be able to see their character's entries and monitor the stories as pas along. This App also works with a physical key-card, which allows you to pass your story along in person and grants you access to some surprises within the palace.").pulsarFont(style: .body).foregroundColor(.black)
                    Button(action:{
                        presentationMode.wrappedValue.dismiss()
                    }){
                        Text("I think I get it").pulsarFont(style: .primaryButton).foregroundColor(.pink)
                    }
                    Spacer()
                }.padding(SpacingManager.edge.space)
            }
        }
    }
}

struct WhatIsItSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        WhatIsItSwiftUIView()
    }
}
