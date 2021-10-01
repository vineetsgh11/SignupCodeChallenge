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
            SignupView(viewModel: SignupViewModel())
        }
    }
}
