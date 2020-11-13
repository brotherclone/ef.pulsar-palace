//
//  AlertUIView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 11/13/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI

struct AlertUIView: View {
    
    @Environment(\.presentationMode) var presentationMode

    @State var pulsarError: PulsarError! = nil
    @State var additionalMessage: String?
    @State var buttonText: String?
    
    var body: some View {
        
        VStack {
            Text(pulsarError.localizedDescription).pulsarFont(style: .h3).foregroundColor(Color.blue)
            Text(pulsarError.failureReason ?? "").pulsarFont(style: .moreEmphasis)
                .padding(SpacingManager.oddOne.space)
            Text(pulsarError.recoverySuggestion ?? "").pulsarFont(style: .lessEmphasis)
                .padding(SpacingManager.oddOne.space)
            if additionalMessage != nil {
                Text(additionalMessage ?? "")
            }
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text(buttonText ?? "Ok").pulsarFont(style: .body).foregroundColor(Color.blue)
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.pink)
        .edgesIgnoringSafeArea(.all)
        
    }
}

