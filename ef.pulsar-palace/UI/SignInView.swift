//
//  SignInView.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 8/21/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import SwiftUI
import Moya
import SwiftyJSON


class SignUpVersusSignInHelper: ObservableObject {
    @Published var signIn: Bool = true
}

struct SignInView: View {
    
    @ObservedObject var signInSignUpHelper = SignUpVersusSignInHelper()
    @ObservedObject var authenticationHelper = AuthenticationHelper()
    
    @State private var usernameInput: String = ""
    @State private var emailInput: String = ""
    @State private var passWordInput: String = ""
    @State private var confirmPassWordInput: String = ""
    @State private var firstNameInput: String = ""
    @State private var lastNameInput: String = ""
    
    
    func postSignUp(user: User, postSignUpCompletionHandler: @escaping (Response?, Error?) -> Void) {
        let networkManager = NetworkManager.provider
        networkManager.request(.signUp(user: user)){ result in
            switch result{
            case let .success(moyaResponse):
                return postSignUpCompletionHandler(moyaResponse, nil)
            case let .failure(error):
                return postSignUpCompletionHandler(nil, error)
            }
        }
    }
    
    func postSignIn(user: UserSignIn, postSignInCompletionHanlder: @escaping (Response?, Error?) -> Void){
        let networkManager = NetworkManager.provider
        networkManager.request(.signIn(user: user)){ result in
            switch result{
            case let .success(moyaResponse):
                postSignInCompletionHanlder(moyaResponse, nil)
            case let .failure(error):
                postSignInCompletionHanlder(nil, error)
            }
        }
    }
    
    func setAccessToken(data: Data){
        do{
            let json = try JSON(data:data)
            if let token:String = json["token"].string {
                let defaults = UserDefaults.standard
                defaults.setValue(token, forKey: "Token")
                authenticationHelper.token = token
                authenticationHelper.isLoggedIn = true
                if let id:Int = json["id"].int{
                    defaults.setValue(id, forKey: "UserId")
                }
            }else{
                print("can not set token")
            }
        }catch{
            print("parsing error")
        }
    }
    
    
    var body: some View {
        Group{
            NavigationLink(destination: MainView(), isActive: $authenticationHelper.isLoggedIn){}
            if signInSignUpHelper.signIn{
                Group{
                    Text("Sign In")
                    TextField("Email", text: $emailInput)
                    TextField("Password", text: $passWordInput)
                    Button(action: {
                        let userSignIn = UserSignIn(email: "example10@example.com", password: "password")
                        self.postSignIn(user: userSignIn, postSignInCompletionHanlder: { response, error in
                            if error != nil{
                                print(error as Any)
                            }else{
                                if let data:Data = response?.data{
                                    self.setAccessToken(data: data)
                                }
                            }
                            
                        })
                    }) {
                        Text("Submit")
                    }
                    Button(action: {
                        self.signInSignUpHelper.signIn.toggle()
                    }) {
                        Text("Create Account")
                    }
                }
            }else{
                Group{
                    Text("Sign Up")
                    TextField("First Name", text: $firstNameInput)
                    TextField("Last Name", text: $lastNameInput)
                    TextField("Email", text: $emailInput)
                    TextField("Password", text: $passWordInput)
                    TextField("Confirm Password", text: $confirmPassWordInput)
                    Button(action: {
                        let userSignUp: User = User(id:nil, first_name: "first", last_name:"last", email:self.emailInput, password: "password")
                        self.postSignUp(user: userSignUp, postSignUpCompletionHandler: { response, error in
                            if error != nil{
                                print(error as Any)
                            }else{
                                if let data:Data = response?.data{
                                    self.setAccessToken(data: data)
                                }
                            }
                            
                        })
                        
                    }) {
                        Text("Submit")
                    }
                    Button(action: {
                        self.signInSignUpHelper.signIn.toggle()
                    }){
                        Text("I have an account. Sign In.")
                    }
                }
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
