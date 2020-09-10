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
import SwiftyJSON


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
        self.requestTagValidation(uuid: result, requestTagValidationCompletionHandler: { response, error in
            if error != nil{
                print(error as Any)
            } else {
                print(response as Any)
                do {
                    let data = response!.data
                    let json = try JSON(data: data)
                    let userId = json["user_id"].stringValue
                    self.checkTagAgainstUser(tagUserId: userId)
                    
                } catch  {
                    print("error")
                }
            }
        })
    }
    
    // MARK: Temp should ask user to log in or give error message.
    
    func checkTagAgainstUser(tagUserId: String){
        if UserDefaults.contains("user_id") {
            let userDefaults = UserDefaults.standard
            if let userId = userDefaults.string(forKey: "user_id")! as String? {
                if userId == tagUserId {
                    print("match")
                }else{
                    print("double nope")
                }
            }
        }else{
            print("nope")
        }
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
    
    func requestTagValidation(uuid: String, requestTagValidationCompletionHandler: @escaping (Response?, Error?) -> Void) {
        let networkProvider = NetworkManager.provider
        networkProvider.request(.checkTag(uuid: uuid), completion: {result in
            switch result{
            case let .success(moyaResponse):
                requestTagValidationCompletionHandler(moyaResponse, nil)
            case let .failure(error):
                requestTagValidationCompletionHandler(nil, error)
            }
        })
    }
}



