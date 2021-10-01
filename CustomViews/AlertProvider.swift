//
//  AlertProvider.swift
//  SignupCodeChallenge
//
//  Created by Vineet Singh on 10/1/21.
//

import Foundation
import SwiftUI

class AlertProvider {
    struct Alert {
        var title: String
        let message: String
        let dismissButtonText: String
    }

    @Published var shouldShowAlert = false

    var alert: Alert? = nil { didSet { shouldShowAlert = alert != nil } }
}

extension Alert {
    init(_ alert: AlertProvider.Alert) {
        self.init(title: Text(alert.title),
                  message: Text(alert.message),
                  dismissButton: .cancel(Text(alert.dismissButtonText)))
    }
}
