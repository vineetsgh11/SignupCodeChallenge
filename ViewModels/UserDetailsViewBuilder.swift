//
//  UserDetailsViewBuilder.swift
//  SignupCodeChallenge
//
//  Created by Vineet Singh on 10/1/21.
//

import Foundation

import SwiftUI

enum UserDetailsViewBuilder {
  static func makeUserDetailView(withUserManagerService service: UserManagerServiceProtocol) -> some View
    {
    let viewModel = UserDetailViewModel(userManagerService: service)
    return UserDetailView(viewModel: viewModel)
  }
}
