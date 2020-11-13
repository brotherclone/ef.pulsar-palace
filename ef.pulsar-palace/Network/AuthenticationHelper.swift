//
//  AuthenticationHelper.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 9/11/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import Foundation

class AuthenticationHelper: ObservableObject {
    
    @Published var isLoggedIn: Bool = false
    @Published var token: String? = nil
    @Published var currentUserId: Int? = nil
    
    func setToken(tokenData: String){
        let defaults = UserDefaults.standard
        defaults.setValue(tokenData, forKey: UserDefaults.Keys.token)
        token = defaults.string(forKey: UserDefaults.Keys.token)
    }
    
    func deleteAll(){
        signOut()
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
    func signOut(){
        let defaults = UserDefaults.standard
        defaults.setValue(nil, forKey: UserDefaults.Keys.currentUserId)
        defaults.setValue(nil, forKey: UserDefaults.Keys.token)
        isLoggedIn = false
    }
    
    func setCurrentUser(user: User){
        let defaults = UserDefaults.standard
        defaults.setValue(user.id, forKey: UserDefaults.Keys.currentUserId)
        currentUserId = defaults.integer(forKey: UserDefaults.Keys.currentUserId)
        isLoggedIn = true
    }
    
    func getAutenticationInfo() -> (Bool,String?, Int?){
        
        let defaults = UserDefaults.standard
        
        if UserDefaults.contains(UserDefaults.Keys.isLoggedIn){
            isLoggedIn = defaults.bool(forKey: UserDefaults.Keys.isLoggedIn)
        }else{
            isLoggedIn = false
        }
        
        if UserDefaults.contains(UserDefaults.Keys.token){
            token = defaults.string(forKey: UserDefaults.Keys.token)
        }
        
        if UserDefaults.contains(UserDefaults.Keys.currentUserId){
            currentUserId = defaults.integer(forKey: UserDefaults.Keys.currentUserId)
        }
        
        return (isLoggedIn, token, currentUserId)
    }
    
    func refreshAutenticationInfo(){
        let _: (Bool, String?, Int?) = self.getAutenticationInfo()
    }
}
