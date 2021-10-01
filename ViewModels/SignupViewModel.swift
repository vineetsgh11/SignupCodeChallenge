//
//  SignupViewModel.swift
//  SignupCodeChallenge
//
//  Created by Vineet Singh on 10/1/21.
//

import Foundation
import SwiftUI
import Combine

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
    @Published var isShowPhotoLibrary = false
    @Published var enableSubmitButton = false
    @Published var profilePictureData : Data?
    @Published var pushDetailView = false


    let descriptionText = "Use the form below to submit your portfolio. An email and password are required."

    var isEmailValid : Bool   = false
    var isWebsiteUrlValid : Bool   = true

    private let authenticatonService: AuthenticationServiceProtocol
    private let userManagerService: UserManagerServiceProtocol
    
    init( authenticatonService: AuthenticationServiceProtocol, userManagerService : UserManagerServiceProtocol)
    {
        self.authenticatonService = authenticatonService
        self.userManagerService = userManagerService
    }
    
    func AuthenticateUser()
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
    
    func updateSubmitButton()
    {
        enableSubmitButton = !emailAddress.isEmpty && !password.isEmpty
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

