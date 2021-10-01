//
//  SignupTextField.swift
//  SignupCodeChallenge
//
//  Created by Vineet Singh on 10/1/21.
//

import SwiftUI

enum TextFieldType
{
    case regular
    case password
}

struct SignupTextField : View
{
    let title : String
    let accessibilityIdentifier : String
    let text : Binding<String>
    let type : TextFieldType

    init(_ title: String, text: Binding<String>, type : TextFieldType, accessibilityIdentifier : String)
    {
        self.title = title
        self.text =  text
        self.type = type
        self.accessibilityIdentifier = accessibilityIdentifier
    }
    
    var body: some View
    {
        
        switch(self.type)
        {
        case .password:
            return AnyView(SecureField(title, text: text)
                            .frame(minWidth: 50, idealWidth: .infinity, maxWidth: .infinity, minHeight: 44, idealHeight: 55, maxHeight: 55, alignment: .center)
                            .textFieldStyle(.plain)
                            .padding([.horizontal], 20)
                            .cornerRadius(12)
                            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                            .padding([.horizontal], 0)
                            .autocapitalization(.none))
                .accessibilityLabel(title)
                .accessibilityIdentifier(accessibilityIdentifier)
        default :
            return AnyView(TextField(title, text: text)
                            .frame(minWidth: 50, idealWidth: .infinity, maxWidth: .infinity, minHeight: 44, idealHeight: 55, maxHeight: 55, alignment: .center)
                            .textFieldStyle(.plain)
                            .padding([.horizontal], 20)
                            .cornerRadius(12)
                            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                            .padding([.horizontal], 0)
                            .autocapitalization(.none))
                .accessibilityLabel(title)
                .accessibilityIdentifier(accessibilityIdentifier)
        }
    }
}
