//
//  SongPlayerViewRepresent.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 8/29/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI
import UIKit

struct SongPlayerViewRepresent: UIViewControllerRepresentable {
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SongPlayerViewRepresent>) -> SongPlayerViewController {
        let songPlayerV = SongPlayerViewController()
        return songPlayerV
    }
    
    func updateUIViewController(_ uiViewController: SongPlayerViewController, context: UIViewControllerRepresentableContext<SongPlayerViewRepresent>) {
    }
}
