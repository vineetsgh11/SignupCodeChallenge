//
//  User.swift
//  SignupCodeChallenge
//
//  Created by Vineet Singh on 10/1/21.
//

import Foundation

struct User
{
    var id = UUID()
    let firstName : String
    let emailAddress : String
    let website : String
    let profilePictureData : Data?
}
