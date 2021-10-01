//
//  UserManagerService.swift
//  SignupCodeChallenge
//
//  Created by Vineet Singh on 10/1/21.
//

import Foundation

protocol UserManagerServiceProtocol {
    func UpdateUser(user : User?)
    func getUser() -> User?
    func hasValidUser() -> Bool

}

class UserManagerService : UserManagerServiceProtocol {
    
    private var loggdInUser : User?
    
    func UpdateUser(user: User?) {
        loggdInUser = user
    }
    
    func getUser() -> User? {
        return loggdInUser
    }
    
    func hasValidUser() -> Bool {
        return loggdInUser != nil
    }
}
