//
//  ContentView.swift
//  SignupCodeChallenge
//
//  Created by Vineet Singh on 10/1/21.
//

import SwiftUI

struct SignupView: View {
    
    @State private var selectedImage: UIImage?
    
    @ObservedObject var viewModel: SignupViewModel
    
        
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 15) {
                
                profileCreationText
                
                informationText
                
                profileImageButton
                                
                SignupTextField("First Name", text: $viewModel.firstName, type: .regular, accessibilityIdentifier: "firstNameField", keyboardType: .default)
                
                SignupTextField("Email Address *", text: $viewModel.emailAddress, type: .regular, accessibilityIdentifier: "emailAddressField", keyboardType: .emailAddress)
                
                SignupTextField("Password *", text: $viewModel.password, type: .password, accessibilityIdentifier:  "passwordField", keyboardType: .default)
                
                SignupTextField("Website", text: $viewModel.website, type: .regular, accessibilityIdentifier: "websiteField", keyboardType: .emailAddress)
                
                Spacer()
                
                submitButton
            }
            .padding()
            .accessibilityLabel("Vertical Stack")
            .accessibilityIdentifier("VerticalStack")
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .sheet(isPresented: $viewModel.showCamera, onDismiss: {
                
                guard let img = self.selectedImage else {return}
                viewModel.profilePictureData = img.jpegData(compressionQuality: 1.0)
            }) {
                ImagePickerView(selectedImage: self.$selectedImage, sourceType: .camera)
            }
        }
        .preferredColorScheme(.light)
        .alert(isPresented: $viewModel.showAlert ) {
                guard let alert = viewModel.alertProvider.alert else { fatalError("Alert not available") }
                return Alert(alert)
        }
    }
}

private extension SignupView {
    
    var userDetailViewNavigationLink: some View {
        Section {
            NavigationLink(destination: viewModel.userDetailView,
                           isActive: $viewModel.pushDetailView) {
                EmptyView()
            }.hidden()}
    }
    
    var profileCreationText : some View
    {
        Section
        {
            Text("Profile Creation")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .minimumScaleFactor(0.5)
                .foregroundColor(Color(.darkGray))
                .accessibilityLabel("Profile Creation")
                .accessibilityIdentifier("profileCreation")
        }
    }
    
    var informationText : some View
    {
        Section
        {
            Text(viewModel.descriptionText)
                .font(.title3)
                .foregroundColor(Color(.gray))
                .fontWeight(.semibold)
                .minimumScaleFactor(0.5)
                .lineLimit(2)
                .accessibilityLabel(viewModel.descriptionText)
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
                    viewModel.requestCamerapermission()
                }, label: {
                    
                    if selectedImage != nil {
                        Image(uiImage: selectedImage!)
                            .resizable()
                            .scaledToFit()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 140, height: 180)
                            .cornerRadius(25)
                            .accessibilityLabel("Profile Picture")
                            .accessibilityIdentifier("profilePicture")
                    } else {
                        Image("TapToAddIcon")
                            .resizable()
                            .clipped()
                            .aspectRatio(contentMode: .fit)
                    }
                })
                    .frame(width: 140, height: 180)
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
                viewModel.AuthenticateUser()
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
                .disabled(!$viewModel.enableSubmitButton.wrappedValue)
                
                userDetailViewNavigationLink
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let userManagerService = UserManagerService()
        let cameraManager = CameraManager()
        let authenticationService = AuthenticationService(userManagerService: userManagerService)
        SignupView(viewModel: SignupViewModel(authenticatonService: authenticationService, userManagerService: userManagerService, cameraManager: cameraManager))
    }
}
