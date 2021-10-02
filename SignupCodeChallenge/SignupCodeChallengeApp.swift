//
//  SignupCodeChallengeApp.swift
//  SignupCodeChallenge
//
//  Created by Vineet Singh on 10/1/21.
//

import SwiftUI

@main
struct SignupCodeChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            let cameraManager = CameraManager()
            let userManagerService = UserManagerService()
            let authenticationService = AuthenticationService(userManagerService: userManagerService)
            
            SignupView(viewModel: SignupViewModel(authenticatonService: authenticationService, userManagerService: userManagerService, cameraManager: cameraManager))
        }
    }
}
