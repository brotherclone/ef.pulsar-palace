//
//  TextFieldExtensions.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 11/2/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI

struct PulsarTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .padding()
            .background(Color.white)
            .border(Color.black)
            .accentColor(Color.pink)
    }
}
