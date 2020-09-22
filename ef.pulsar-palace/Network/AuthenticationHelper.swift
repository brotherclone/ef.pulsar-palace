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
    @Published var currentUser: User? = nil
    
    func setToken(tokenData: String){
        let defaults = UserDefaults.standard
        defaults.setValue(tokenData, forKey: UserDefaults.Keys.token)
        token = defaults.string(forKey: UserDefaults.Keys.token)
    }
    
    func setCurrentUser(user: User){
        let defaults = UserDefaults.standard
        defaults.setValue(user, forKey:  UserDefaults.Keys.currentUser)
        currentUser = defaults.object(forKey: UserDefaults.Keys.currentUser) as? User
    }
    
    func getAutenticationInfo() -> (Bool,String?, User?){
        
        let defaults = UserDefaults.standard
        
        if UserDefaults.contains(UserDefaults.Keys.isLoggedIn){
            isLoggedIn = defaults.bool(forKey: UserDefaults.Keys.isLoggedIn)
        }else{
            isLoggedIn = false
        }
        
        if UserDefaults.contains(UserDefaults.Keys.token){
            token = defaults.string(forKey: UserDefaults.Keys.token)
        }
        
        if UserDefaults.contains(UserDefaults.Keys.currentUser){
            currentUser = defaults.object(forKey: UserDefaults.Keys.currentUser) as? User
        }
        
        return (isLoggedIn, token, currentUser)
    }
    
    func refreshAutenticationInfo(){
        let _: (Bool, String?, User?) = self.getAutenticationInfo()
    }
}