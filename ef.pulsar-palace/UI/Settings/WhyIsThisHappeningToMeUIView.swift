//
//  WhyIsThisHappeningToMeUIView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 11/10/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI

struct WhyIsThisHappeningToMeUIView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack{
            Color.yellow
                .ignoresSafeArea()
            Group{
                VStack(spacing: SpacingManager.oddTwo.space){
                    Spacer()
                    Text("Why is this happening to me?").pulsarFont(style: .h1).foregroundColor(.black)
                    Text("Your characters in Pulsar Palace come from turbulent settings and possess a unique combination of skills and demeanors. Maybe they come to Pulsar Palace in a trance, a skyship, or a dream? It's up to you. Oh, I'm sorry, did you mean something is happening to you in real life? The answer to that will come in two days.").pulsarFont(style: .body).foregroundColor(.black)
                    Button(action:{
                        presentationMode.wrappedValue.dismiss()
                    }){
                        Text("Umm... Okay").pulsarFont(style: .primaryButton).foregroundColor(.pink)
                    }
                    Spacer()
                }.padding(SpacingManager.oddOne.space)
            }
        }
    }
}

struct WhyIsThisHappeningToMeUIView_Previews: PreviewProvider {
    static var previews: some View {
        WhyIsThisHappeningToMeUIView()
    }
}
