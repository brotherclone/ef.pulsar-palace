//
//  SettingsUIView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 11/4/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI

struct SettingsUIView: View {
    
    @Binding var showMenu: Bool

    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                   withAnimation {
                      self.showMenu = false
                   }
               }) {
                   Text("🍔")
               }
            HStack {
                Image(systemName: "person")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("Profile")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            .padding(.top, 100)
            HStack {
                Image(systemName: "envelope")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("Messages")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            .padding(.top, 30)
            HStack {
                Image(systemName: "gear")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("Settings")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            .padding(.top, 30)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.blue)
        .edgesIgnoringSafeArea(.all)
    }
    
}

//struct SettingsUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsUIView()
//    }
//}
