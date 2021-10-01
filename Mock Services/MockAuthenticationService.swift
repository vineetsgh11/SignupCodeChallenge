//
//  MockAuthenticationService.swift
//  SignupCodeChallenge
//
//  Created by Vineet Singh on 10/1/21.
//

import Foundation

class MockAuthenticationService : AuthenticationServiceProtocol {
    
    var isAuthenticateUserCalled = false
    
    private let userManagerService: UserManagerServiceProtocol

    init(userManagerService : UserManagerServiceProtocol)
    {
        self.userManagerService = userManagerService
    }
    
    // Make sure the API calls once they are finished modify the values on the Main Thread
    func authenticateUser(name : String, email : String, password : String, profilePicture : Data?, website : String, completion : @escaping (authenticationHandler) -> ())
    {
        isAuthenticateUserCalled = true
        let user = User(firstName: name, emailAddress: email, website: website, profilePictureData: profilePicture)
        self.userManagerService.UpdateUser(user: user)
        completion(.success(user))
    }
}
