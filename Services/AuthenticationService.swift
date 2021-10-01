//
//  AuthenticationService.swift
//  SignupCodeChallenge
//
//  Created by Vineet Singh on 10/1/21.
//

import Foundation


typealias authenticationHandler = Result<User, Error>

protocol AuthenticationServiceProtocol {
    func authenticateUser(name : String, email : String, password : String, profilePicture : Data?, website : String, completion : @escaping (authenticationHandler) -> ())
}

class AuthenticationService : AuthenticationServiceProtocol {
    
    private let userManagerService: UserManagerServiceProtocol

    init(userManagerService : UserManagerServiceProtocol)
    {
        self.userManagerService = userManagerService
    }
    
    
    // Make sure the API calls once they are finished modify the values on the Main Thread
    func authenticateUser(name : String, email : String, password : String, profilePicture : Data?, website : String, completion : @escaping (authenticationHandler) -> ())
    {
        let user = User(firstName: name, emailAddress: email, website: website, profilePictureData: profilePicture)
        
        userManagerService.UpdateUser(user: user)
        
        // make server call using nsurl session
        completion(.success(user))
    }
}
