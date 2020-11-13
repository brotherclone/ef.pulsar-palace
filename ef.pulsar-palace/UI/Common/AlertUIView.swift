//
//  AlertUIView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 11/13/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI

struct AlertUIView: View {
    
    @State var isPresented: Bool = false
    @State var pulsarError: PulsarError! = nil
    
    
    var body: some View {
        
        Group {
            Text(pulsarError.localizedDescription)
        }
        
    }
}

