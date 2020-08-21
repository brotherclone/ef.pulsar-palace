//
//  HaveCardView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 8/21/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI

struct HaveCardView: View {
    var body: some View {

            VStack{
                Text("Got a card?")
            
            Button(action:{
                print("tap")
            }){
                Text("Scan now")
            }
            NavigationLink(destination: CreateACharacterView()){
                Text("Nope")
            }
        }
    }
}

struct HaveCardView_Previews: PreviewProvider {
    static var previews: some View {
        HaveCardView()
    }
}
