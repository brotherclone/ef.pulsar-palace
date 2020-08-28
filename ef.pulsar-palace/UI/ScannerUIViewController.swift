//
//  ScannerUIViewController.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 8/26/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import UIKit
import CoreNFC
import SwiftUI
import Moya


class ScannerUIViewController: UIViewController, NFCNDEFReaderSessionDelegate {
    
    
    var nfcSession: NFCNDEFReaderSession?
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        if let readerError = error as? NFCReaderError {
            if (readerError.code != .readerSessionInvalidationErrorFirstNDEFTagRead)
                && (readerError.code != .readerSessionInvalidationErrorUserCanceled) {
                print("The session was invalidated: \(error.localizedDescription)")
            }
        }
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        DispatchQueue.main.async {
            self.handleScan(messages: messages)
        }
    }
    
    func handleScan(messages: [NFCNDEFMessage]){
        var result = ""
        for payload in messages[0].records {
            result += String.init(data: payload.payload.advanced(by: 3), encoding: .utf8)!
        }
        self.requestTagValidation(scanUrl: result, requestTagValidationCompletionHandler: { response, error in
            if error != nil{
                print(error as Any)
            }else{
                print(response as Any)
                do {
                    let data = try response!.mapJSON()
                    print(data)
                } catch{
                    print("error")
                }
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        button.center = view.center
        button.backgroundColor = .systemPink
        button.setTitle("Scan", for: .normal)
        button.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
        self.view.addSubview(button)
        
    }
    
    @objc func buttonClicked() {
        print("Button Clicked")
        nfcSession = NFCNDEFReaderSession.init(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        nfcSession?.begin()
    }
    
    func requestTagValidation(scanUrl: String, requestTagValidationCompletionHandler: @escaping (Response?, Error?) -> Void) {
        let networkProvider = NetworkManager.provider
        networkProvider.request(.getPlayerCharacterData, completion: {result in
            switch result{
            case let .success(moyaResponse):
                requestTagValidationCompletionHandler(moyaResponse, nil)
            case let .failure(error):
                requestTagValidationCompletionHandler(nil, error)
            }
        })
        
    }
}



