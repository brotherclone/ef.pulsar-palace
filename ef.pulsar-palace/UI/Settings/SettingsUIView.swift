//
//  SettingsUIView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 11/4/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI


class SettingsViewStatusHelper: ObservableObject {
    @Published var doLogOut: Bool = false
}

struct SettingsUIView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var authtenticationHelper = AuthenticationHelper()
    @ObservedObject var settingsViewStatusHelper = SettingsViewStatusHelper()
    
    @State private var whatIsItPresented = false
    @State private var whatIsAnEarthlyFramePresented = false
    @State private var whyIsThisHappeningToMePresented = false
    
    var body: some View {
        VStack{
            NavigationLink(destination: StartView(), isActive: $settingsViewStatusHelper.doLogOut){}
            Button("Close"){
                presentationMode.wrappedValue.dismiss()
            }
            VStack(spacing:SpacingManager.barely.space){
                Text("Accounts").pulsarFont(style: .h2)
                Button(action: {
                    self.authtenticationHelper.deleteAll()
                    self.settingsViewStatusHelper.doLogOut = true
                }
                ){
                    SettingsRowItemUIView(buttonText: "Delete Everything! Salt the Earth!")
                }
                Button(action: {
                    self.authtenticationHelper.signOut()
                    self.settingsViewStatusHelper.doLogOut = true
                }
                ){
                    SettingsRowItemUIView(buttonText: "Sign Out")
                }
            }
            Divider()
            VStack(spacing:SpacingManager.barely.space){
                Text("About").pulsarFont(style: .h2)
                Button(action: {
                    self.whatIsItPresented.toggle()
                }
                ){
                    SettingsRowItemUIView(buttonText: "What is this?")
                }.fullScreenCover(isPresented: $whatIsItPresented, content: WhatIsItSwiftUIView.init)
                Button(action: {
                    self.whatIsAnEarthlyFramePresented.toggle()
                }
                ){
                    SettingsRowItemUIView(buttonText: "What is an Earthly Frame?")
                }.fullScreenCover(isPresented: $whatIsAnEarthlyFramePresented, content: WhatIsAnEarthlyFrameUIView.init)
                Button(action: {
                    self.whyIsThisHappeningToMePresented.toggle()
                }
                ){
                    SettingsRowItemUIView(buttonText: "Why is this happening to me?")
                }.fullScreenCover(isPresented: $whyIsThisHappeningToMePresented, content: WhyIsThisHappeningToMeUIView.init)
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue)
        .edgesIgnoringSafeArea(.all)
    }
}

struct SettingsUIView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsUIView()
    }
}



