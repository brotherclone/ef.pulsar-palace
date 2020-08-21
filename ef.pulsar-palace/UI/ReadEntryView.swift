//
//  ReadEntryView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 8/21/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI

struct ReadEntryView: View {
    var body: some View {

            VStack{
                Text("Read")
                NavigationLink(destination: MainView()){
                        Text("Cool")
                    }
            }
        }
  
}

struct ReadEntryView_Previews: PreviewProvider {
    static var previews: some View {
        ReadEntryView()
    }
}
