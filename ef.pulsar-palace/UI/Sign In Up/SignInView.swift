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
    @Published var showError: Bool = false
    @Published var currentErrror: PulsarError? = nil
}

struct SignInView: View {
    
    @ObservedObject var signInSignUpHelper = SignUpVersusSignInHelper()
    @ObservedObject var authenticationHelper = AuthenticationHelper()
    
    @State private var usernameInput: String = ""
    // MARK: For Dev only
    @State private var emailInput: String = "example1@example.com"
    // MARK: For Dev only
    @State private var passWordInput: String = "password"
    @State private var confirmPassWordInput: String = ""
    @State private var firstNameInput: String = ""
    @State private var lastNameInput: String = ""
    
    @State var isAlerting: Bool = false
    
    var currentError: PulsarError? = nil
        
    func postSignUp(user: UserSignUp, postSignUpCompletionHandler: @escaping (Response?, Error?) -> Void) {
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
        print("postSignIn: \(user)")
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
        print("setAccessToken: \(data)")
        do{
            let json = try JSON(data:data)
            if let token:String = json["token"].string {
                print("setting token: \(token)")
                authenticationHelper.setToken(tokenData: token)
                if let id:Int = json["id"].int{
                    if let email:String = json["email"].string{
                        let userData: User = User(id: id, first_name: json["first_name"].string, last_name: json["last_name"].string, email: email)
                        print("setting user: \(userData)")
                        authenticationHelper.setCurrentUser(user: userData)
                    }
                }
            }else{
                let error: Error = PulsarError.unableToSetToken
                print(error.localizedDescription)
            }
        }catch{
            let error: Error = PulsarError.parsingError
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        ZStack{
            Color.yellow
                .ignoresSafeArea()
            Group{
                NavigationLink(destination: MainView(), isActive: $authenticationHelper.isLoggedIn){}
                    .alert(isPresented: $signInSignUpHelper.showError){
                        return Alert(title: Text((signInSignUpHelper.currentErrror?.errorDescription)!), message: Text((signInSignUpHelper.currentErrror?.failureReason)!), dismissButton: .default(Text("Ok")))
                    }
                if signInSignUpHelper.signIn{
                    Group{
                        VStack{
                            SettingsButtonUIView()
                            Image("temp")
                                .resizable()
                                .scaledToFit()
                            Text("Sign In").pulsarFont(style: .h2)
                            TextField("Email", text: $emailInput).textFieldStyle(PulsarTextFieldStyle())
                            TextField("Password", text: $passWordInput).textFieldStyle(PulsarTextFieldStyle())
                            Button(action: {
                                let userSignIn = UserSignIn(email: self.emailInput, password: self.passWordInput)
                                self.postSignIn(user: userSignIn, postSignInCompletionHanlder: { response, error in
                                    if error != nil{
                                        signInSignUpHelper.currentErrror = PulsarError.connectionError
                                        signInSignUpHelper.showError = true
                                    }else{
                                        if let data:Data = response?.data{
                                            self.setAccessToken(data: data)
                                        }
                                    }
                                })
                            }) {
                                Text("Submit").pulsarFont(style: .primaryButton).foregroundColor(Color.pink)
                            }
                            Button(action: {
                                self.signInSignUpHelper.signIn.toggle()
                            }) {
                                Text("Create Account").pulsarFont(style: .secondaryButton).foregroundColor(Color.pink)
                            }
                        }
                    }
                }else{
                    Group{
                        VStack{
                            SettingsButtonUIView()
                            Image("temp")
                                .resizable()
                                .scaledToFit()
                            Text("Sign Up").pulsarFont(style: .h2)
                            TextField("First Name", text: $firstNameInput).textFieldStyle(PulsarTextFieldStyle())
                            TextField("Last Name", text: $lastNameInput).textFieldStyle(PulsarTextFieldStyle())
                            TextField("Email", text: $emailInput).textFieldStyle(PulsarTextFieldStyle())
                            TextField("Password", text: $passWordInput).textFieldStyle(PulsarTextFieldStyle())
                            TextField("Confirm Password", text: $confirmPassWordInput).textFieldStyle(PulsarTextFieldStyle())
                            Button(action: {
                                let userSignUp: UserSignUp = UserSignUp(id:nil, first_name:  self.firstNameInput, last_name: self.lastNameInput, email:self.emailInput, password: self.passWordInput)
                                self.postSignUp(user: userSignUp, postSignUpCompletionHandler: { response, error in
                                    if error != nil{
                                        signInSignUpHelper.currentErrror = PulsarError.connectionError
                                        signInSignUpHelper.showError = true
                                    }else{
                                        if let data:Data = response?.data{
                                            self.setAccessToken(data: data)
                                        }
                                    }
                                })
                            }) {
                                Text("Submit").pulsarFont(style: .primaryButton).foregroundColor(Color.pink)
                            }
                            Button(action: {
                                self.signInSignUpHelper.signIn.toggle()
                            }){
                                Text("I have an account. Sign In.").pulsarFont(style: .secondaryButton).foregroundColor(Color.pink)
                            }
                        }
                    }
                }
            }
        }.navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}
