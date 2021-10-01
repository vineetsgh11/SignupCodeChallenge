//
//  ButtonStyle.swift
//  SignupCodeChallenge
//
//  Created by Vineet Singh on 10/1/21.
//

import Foundation
import SwiftUI

struct CustomButtonStyle: ButtonStyle {
  func makeBody(configuration: Self.Configuration) -> some View {
      CustomButtonStyleView(configuration: configuration)
  }
}

private extension CustomButtonStyle {
  struct CustomButtonStyleView: View {
    // tracks if the button is enabled or not
    @Environment(\.isEnabled) var isEnabled
    // tracks the pressed state
    let configuration: CustomButtonStyle.Configuration

    var body: some View {
      return configuration.label
        // change the text color based on if it's disabled
        .foregroundColor(isEnabled ? .white : .gray)
        .background(RoundedRectangle(cornerRadius: 10)
          // change the background color based on if it's disabled
          .fill(isEnabled ? Color.defaultBlue : Color.paleBlue)
        )
        // make the button a bit more translucent when pressed
        .opacity(configuration.isPressed ? 0.8 : 1.0)
        // make the button a bit smaller when pressed
        .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
    }
  }
}
