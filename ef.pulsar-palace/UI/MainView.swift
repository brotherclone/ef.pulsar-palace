//
//  MainView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 8/21/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI
import Moya
import SwiftyJSON

struct MainView: View {
    
    func getUsersCharacters(userId:Int, getUsersCharactersCompletionHanlder: @escaping (Response?, Error?) -> Void){
        if UserDefaults.contains("Token"){
            let defaults = UserDefaults.standard
            let token = defaults.string(forKey:"Token")
            let authPlugin = AccessTokenPlugin { _ in token! }
            let authenticatedProvider = MoyaProvider<APITargets>(plugins: [authPlugin])
            authenticatedProvider.request(.getUsersCharacters(userId: 1)){ result in
                switch result{
                case let .success(moyaResponse):
                    getUsersCharactersCompletionHanlder(moyaResponse, nil)
                case let .failure(error):
                    getUsersCharactersCompletionHanlder(nil, error)
                }
            }
        }
    }
    
    func getPlayerCharacterData(getPlayerCharacterDataCompletionHandler: @escaping (Response?, Error?) -> Void){
        let networkProvider = NetworkManager.provider
        networkProvider.request(.getPlayerCharacterInfo){ result in
            switch result{
            case let .success(moyaResponse):
                getPlayerCharacterDataCompletionHandler(moyaResponse, nil)
            case let .failure(error):
                getPlayerCharacterDataCompletionHandler(nil, error)
            }
        }
    }
    
    
    // MARK: Flow
    
    // if you not logged in, redirect to sign in
    // if you have only one character and it is active display character sheet, entry prompt, and current entries
    // if you have no active character and have made previous characters, display a way to see their logs, as well as create a character
    // if you have an active character and previous characters,display a way to see their logs, active display character sheet, entry prompt, and current entries
    // if you have no active characters, and have never made a character, display create character and intro text
    
    var body: some View {
        VStack{
            Text("Main Menu")
            NavigationLink(destination: EntryView()){
                Text("Explore")
            }
            NavigationLink(destination: ReadEntryView()){
                Text("Read")
            }
            NavigationLink(destination: CreateACharacterView()){
                Text("Create Character")
            }
            NavigationLink(destination: SendView()){
                Text("Send to Friend")
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear( perform: {
            self.getPlayerCharacterData(getPlayerCharacterDataCompletionHandler: { response, error in
                if error != nil{
                    print(error as Any)
                }else{
                    print(response as Any)
                    if UserDefaults.contains("UserId"){
                        let defaults = UserDefaults.standard
                        let userId = defaults.integer(forKey: "UserId")
                        self.getUsersCharacters(userId: userId, getUsersCharactersCompletionHanlder: { responseTwo, errorTwo in
                            if errorTwo != nil {
                                print(errorTwo as Any)
                            }else{
                                print(responseTwo as Any)
                            }
                        })
                    }
                }
            })
        })
    }
    
    struct MainView_Previews: PreviewProvider {
        static var previews: some View {
            MainView()
        }
    }
}
