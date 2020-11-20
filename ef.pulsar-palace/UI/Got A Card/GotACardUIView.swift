//
//  GotACardUIView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 11/15/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI

struct GotACardUIView: View {
    var body: some View {
        ZStack{
            Color.yellow
                .ignoresSafeArea()
            VStack{
                SettingsButtonUIView()
                Image("temp")
                    .resizable()
                Text("Do you own a Pulsar Palace room key?").pulsarFont(style: .h2).foregroundColor(Color.black)
                NavigationLink(destination: ScannerView()){
                    Text("Yes").pulsarFont(style: .primaryButton).foregroundColor(Color.pink)
                }
                NavigationLink(destination: SignInView()){
                    Text("Why No, I don't").pulsarFont(style: .primaryButton).foregroundColor(Color.pink)
                }
                NavigationLink(destination: WhatIsItSwiftUIView()){
                    Text("I haven't the sligtest idea what you're talking about").pulsarFont(style: .secondaryButton).foregroundColor(Color.pink)
                }
            }
        }
    }
}

