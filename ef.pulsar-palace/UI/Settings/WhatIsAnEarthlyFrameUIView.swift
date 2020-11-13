//
//  WhatIsAnEarthlyFrameUIView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 11/10/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI

struct WhatIsAnEarthlyFrameUIView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack{
            Color.yellow
                .ignoresSafeArea()
            Group{
                VStack(spacing: SpacingManager.oddTwo.space){
                    Spacer()
                    Text("What is an Earthly Frame?").pulsarFont(style: .h1).foregroundColor(.black)
                    Text("An earthly frame refers to your physical body, of course. Oh, you mean the band? It's just a guy in his basement who churns out a lot of weird music. Each room in the Pulsar Palace has a song by this obscure, musical artist.").pulsarFont(style: .body).foregroundColor(.black)
                    Button(action:{
                        presentationMode.wrappedValue.dismiss()
                    }){
                        Text("Got it").pulsarFont(style: .primaryButton).foregroundColor(.pink)
                    }
                    Spacer()
                }.padding(SpacingManager.oddOne.space)
            }
        }
    }
}

struct WhatIsAnEarthlyFrameUIView_Previews: PreviewProvider {
    static var previews: some View {
        WhatIsAnEarthlyFrameUIView()
    }
}
