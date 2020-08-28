//
//  MainView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 8/21/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
            VStack{
                Text("Main Menu")
                NavigationLink(destination: EntryView()){
                    Text("Explore")
                }
                NavigationLink(destination: ReadEntryView()){
                        Text("Read")
                    }
                NavigationLink(destination: CreateACharacterView()){
                        Text("Create Character")
                    }
                NavigationLink(destination: SendView()){
                        Text("Send to Friend")
                    }
            }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
