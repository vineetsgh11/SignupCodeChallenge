//
//  ContentView.swift
//  SignupCodeChallenge
//
//  Created by Vineet Singh on 10/1/21.
//

import SwiftUI

struct SignupView: View {
    
    @State private var selectedImage: UIImage?
    
    @State private var isShowPhotoLibrary: Bool = false
    @State private var firstName: String = ""
    @State private var emailAddress: String = ""
    @State private var password: String = ""
    @State private var website: String = ""
    let descriptionText = "Use the form below to submit your portfolio. An email and password are required."


        
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 15) {
                
                profileCreationText
                
                informationText
                
                profileImageButton
                
                SignupTextField("First Name", text: $firstName, type: .regular, accessibilityIdentifier: "firstNameField")
                
                SignupTextField("EmailAddress", text: $emailAddress, type: .regular, accessibilityIdentifier: "emailAddressField")
                
                SignupTextField("Password", text: $password, type: .password, accessibilityIdentifier:  "passwordField")
                
                SignupTextField("Website", text: $website, type: .regular, accessibilityIdentifier: "websiteField")
                
                Spacer()
                
                submitButton
            }
            .padding()
            .accessibilityLabel("Vertical Stack")
            .accessibilityIdentifier("VerticalStack")
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

private extension SignupView {
    
    
    var profileCreationText : some View
    {
        Section
        {
            Text("Profile Creation")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(Color(.darkGray))
                .accessibilityLabel("Profile Creation")
                .accessibilityIdentifier("profileCreation")
        }
    }
    
    var informationText : some View
    {
        Section
        {
            Text(descriptionText)
                .font(.title3)
                .foregroundColor(Color(.gray))
                .fontWeight(.semibold)
                .minimumScaleFactor(0.5)
                .lineLimit(2)
                .accessibilityLabel(descriptionText)
                .accessibilityIdentifier("headerDescriptonText")
        }
    }
    
    var profileImageButton : some View
    {
        Section
        {
            HStack(alignment: .center, spacing: 15) {
                Spacer()
                
                Button(action: {
                   print("add image button clicked")
                }, label: {
                    
                    if selectedImage != nil {
                                        Image(uiImage: selectedImage!)
                                        .resizable()
                                        .clipped()
                                        .aspectRatio(contentMode: .fit)
                                    } else {
                                        Image("TapToAddIcon")
                                            .resizable()
                                            .clipped()
                                            .aspectRatio(contentMode: .fit)
                                    }
                })
                    .frame(width: 150, height: 200)
                    .cornerRadius(25)
                    .accessibilityLabel("Tap to add avatar")
                    .accessibilityIdentifier("avatarButton")
                    .disabled(self.selectedImage != nil)
                
                Spacer()
            }
        }
    }
    
    var submitButton : some View
    {
        Section
        {
            Button(action: {
                print("Submit button clicked")
            }, label: {
                Text("Submit")
                    .fontWeight(.bold)
                    .padding()
                    .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 50, idealHeight: 50, maxHeight: 50, alignment: .center)
            })
                .padding(.bottom, 0)
                .accessibilityLabel("Submit")
                .accessibilityIdentifier("submitButton")
                .buttonStyle(CustomButtonStyle())
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
