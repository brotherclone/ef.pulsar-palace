//
//  CreateACharacterView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 8/21/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI

struct CreateACharacterView: View {
    var body: some View {
  
            VStack{
                Text("Create a Character")
                Button(action:{
                    print("tap")
                }){
                    Text("Reroll")
                }
                NavigationLink(destination: MainView()){
                    Text("Uhh Okay")
                }
            }
        }
    
}

struct CreateACharacterView_Previews: PreviewProvider {
    static var previews: some View {
        CreateACharacterView()
    }
}
