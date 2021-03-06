//
//  SignupViewModel.swift
//  SignupCodeChallenge
//
//  Created by Vineet Singh on 10/1/21.
//

import Foundation
import SwiftUI

class SignupViewModel: ObservableObject
{
    @Published var firstName: String = ""
    @Published var emailAddress: String = "" {
        didSet {
            updateSubmitButton()
        }
    }
    @Published var password: String = "" {
        didSet {
            updateSubmitButton()
        }
    }
    @Published var website: String = ""
    @Published var showCamera = false
    @Published var showAlert = false
    @Published var enableSubmitButton = false
    @Published var profilePictureData : Data?
    @Published var pushDetailView = false
    
    var alertProvider = AlertProvider()

    let descriptionText = "Use the form below to submit your portfolio. An email and password are required."

    var isEmailValid : Bool   = false
    var isWebsiteUrlValid : Bool   = true

    private let authenticatonService: AuthenticationServiceProtocol
    private let userManagerService: UserManagerServiceProtocol
    private let cameraManager : CameraManagerProtocol

    
    init( authenticatonService: AuthenticationServiceProtocol, userManagerService : UserManagerServiceProtocol, cameraManager : CameraManagerProtocol)
    {
        self.authenticatonService = authenticatonService
        self.userManagerService = userManagerService
        self.cameraManager = cameraManager
    }
    
    func requestCamerapermission()
    {
        self.cameraManager.requestPermission { [weak self]permission in
            
            guard let self = self else {return}
            
            self.showCamera = permission
            
            if(!permission)
            {
                self.showErrorAlert(title: "", message: "Please enable camera permission in app settings.", dismissButtonText: "OK")
            }
        }
    }
    
    func AuthenticateUser()
    {
        if(canSubmit())
        {
            authenticatonService.authenticateUser(name: firstName, email: emailAddress, password: password, profilePicture: self.profilePictureData, website: website) {[weak self] result in
                
                guard let self = self else {return}
                
                switch(result)
                {
                case .success(let user):
                    print("user is ... \(user)")
                    self.pushDetailView = true
                case .failure(let error):
                    print("login failed.. error : \(error)")
                }
            }
        }
    }
    
    func updateSubmitButton()
    {
        enableSubmitButton = !emailAddress.isEmpty && !password.isEmpty
    }
    
   
}

extension SignupViewModel {
  var userDetailView: some View {
      return UserDetailsViewBuilder.makeUserDetailView(withUserManagerService: self.userManagerService)
  }
    
    func canSubmit() -> Bool
    {
        if(password.count < 8)
        {
            showErrorAlert(title: "", message: "Password should be atleast 8 characters long.", dismissButtonText: "OK")
            return false
        }
        else if(!emailAddress.isValidEmail)
        {
            showErrorAlert(title: "", message: "Please enter valid email address", dismissButtonText: "OK")
            return false
            
        }
        else if(!website.isValidURL)
        {
            showErrorAlert(title: "", message: "Please enter valid website address", dismissButtonText: "OK")
            return false
        }
        
        return true
    }
    
    func showErrorAlert(title : String, message : String, dismissButtonText : String)
    {
        alertProvider.alert = AlertProvider.Alert(
                title: title,
                message: message,
                dismissButtonText: dismissButtonText
            )
        
        showAlert = true

    }
}

extension String {
    var isValidURL: Bool {
        
        // return true to hide error text
        if(self.isEmpty)
        {
            return true
        }
        
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
    
    var isValidEmail : Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}

