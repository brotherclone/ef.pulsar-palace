//
//  SettingsUIView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 11/4/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI

struct SettingsUIView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            Button("Close"){
                presentationMode.wrappedValue.dismiss()
            }
            VStack(spacing:1){
                Text("Accounts").pulsarFont(style: .h2)
                Button(action: {
                    print("delete button")
                }
                ){
                    SettingsRowItemUIView(buttonText: "Delete Everything! Salt the Earth!")
                }
                Button(action: {
                    print("sign out button")
                }
                ){
                    SettingsRowItemUIView(buttonText: "Sign Out")
                }
            }
            Divider()
            VStack(spacing:1){
                Text("About").pulsarFont(style: .h2)
                Button(action: {
                    print("What is it")
                }
                ){
                    SettingsRowItemUIView(buttonText: "What is this?")
                }
                Button(action: {
                    print("earthly button")
                }
                ){
                    SettingsRowItemUIView(buttonText: "What is an Earthly Frame?")
                }
                Button(action: {
                    print("why button")
                }
                ){
                    SettingsRowItemUIView(buttonText: "Why is this happening to me?")
                }
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



