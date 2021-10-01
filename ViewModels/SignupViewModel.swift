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
    @Published var emailAddress: String = ""
    @Published var password: String = ""
    @Published var website: String = ""
    @Published var isShowPhotoLibrary = false
    @Published var enableSubmitButton = false

    let descriptionText = "Use the form below to submit your portfolio. An email and password are required."

    var isEmailValid : Bool   = false
    var isWebsiteUrlValid : Bool   = true

    init()
    {
    }
   
}

