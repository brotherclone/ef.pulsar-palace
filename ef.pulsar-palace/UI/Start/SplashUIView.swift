//
//  SplashUIView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 9/11/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI

struct TextOverlay: View{
    var body: some View{
        Text("Pulsar Palace").pulsarFont(style: .h1).foregroundColor(Color.black)
    }
}

struct SplashUIView: View {
    var body: some View {
        VStack(alignment: .leading){
            Image("palace")
                .resizable()
                .scaledToFit()
                .overlay(TextOverlay(), alignment: .center)
        }
    }
}

struct SplashUIView_Previews: PreviewProvider {
    static var previews: some View {
        SplashUIView()
    }
}
