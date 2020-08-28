//
//  ScannerViewRepresent.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 8/26/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI
import UIKit

struct ScannerViewRepresent: UIViewControllerRepresentable {

    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ScannerViewRepresent>) -> ScannerUIViewController {
            let scannerV = ScannerUIViewController()
        return scannerV
    }
    
    func updateUIViewController(_ uiViewController: ScannerUIViewController, context: UIViewControllerRepresentableContext<ScannerViewRepresent>) {
    }
}
