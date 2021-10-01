//
//  UserDetailViewModel.swift
//  SignupCodeChallengeTests
//
//  Created by Vineet Singh on 10/1/21.
//

import Foundation
@testable import SignupCodeChallenge

class UserDetailViewModel : ObservableObject
{
    private let userManagerService: UserManagerServiceProtocol
    
    var headerText : String{ get { getHeaderText()  } }
    
    var firstName : String { get { getFirstName()} }
    
    var emailAddress : String { get { getEmailAddresss() } }

    var websiteLink : String { get { getWebsiteLink() } }


    init(userManagerService : UserManagerServiceProtocol)
    {
        self.userManagerService = userManagerService
    }
    
    
    let desctiptionText = "Your super awesome portfolio has been successfully submitted! The preview below is what community will see!"
    
    
        
    func getUserProfilePicture() -> Data?
    {
        guard let user = self.userManagerService.getUser() else { return nil}

        return user.profilePictureData
    }
    
    
    func getWebsiteLink() -> String
    {
        guard let user = self.userManagerService.getUser() else { return ""}
        
        return user.website
    }
    
    func getEmailAddresss() -> String
    {
        guard let user = self.userManagerService.getUser() else { return ""}
        
        return user.emailAddress
    }
    
    func getFirstName() -> String
    {
        guard let user = self.userManagerService.getUser() else { return ""}
        
        return user.firstName
    }
    
    func getHeaderText() -> String
    {
        guard let user = self.userManagerService.getUser() else { return ""}
        
        if(user.firstName.isEmpty)
        {
            return "Hello!"
        }
        
        return "Hello, \(user.firstName)!"
        
    }
    
}
