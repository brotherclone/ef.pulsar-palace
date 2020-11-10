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
        VStack{
            Button("Close"){
                presentationMode.wrappedValue.dismiss()
            }
            Text("What is an EF?")
        }
       
    }
}

struct WhatIsAnEarthlyFrameUIView_Previews: PreviewProvider {
    static var previews: some View {
        WhatIsAnEarthlyFrameUIView()
    }
}
