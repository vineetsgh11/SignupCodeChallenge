//
//  UserrDetailView.swift
//
//  Created by Vineet Singh on 10/1/21.
//

import Foundation

import Foundation
import SwiftUI

struct UserDetailView : View {
        
    @ObservedObject var viewModel: UserDetailViewModel
    
    var body: some View {
                    
            VStack(alignment: .leading, spacing: 15)
            {
                welcomeText
                
                descriptionText
                
                HStack(alignment: .center, spacing: 15) {
                    
                    Spacer()
                    
                    VStack(alignment: .center, spacing: 15)
                    {
                        
                        profilePicture
                        
                        if(!viewModel.websiteLink.isEmpty)
                        {
                            Link(viewModel.websiteLink, destination: URL(string: viewModel.websiteLink)!)
                        }
                        
                        if(!viewModel.firstName.isEmpty)
                        {
                            Text(viewModel.firstName)
                            .font(.title2)
                        }
                        
                        Text(viewModel.emailAddress)
                            .font(.title2)
                        
                    }
                    
                    Spacer()
                    
                }
                
                Spacer()
                
                signinButton
                
            }
            .preferredColorScheme(.light)
            .padding()
            .navigationBarTitle("Test")
            .navigationBarHidden(true)
        
    }
        
}

private extension UserDetailView
{
    var welcomeText : some View
    {
        Section
        {
            Text(viewModel.headerText)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(Color(.darkGray))
                .accessibilityLabel(viewModel.headerText)
                .accessibilityIdentifier("welcomeText")
        }
    }
    
    var descriptionText : some View
    {
        Section
        {
            Text(viewModel.desctiptionText)
                .font(.title3)
                .foregroundColor(Color(.gray))
                .fontWeight(.semibold)
                .minimumScaleFactor(0.4)
                .lineLimit(3)
                .accessibilityLabel(viewModel.desctiptionText)
                .accessibilityIdentifier("descriptionText")
        }
    }
    
    var profilePicture : some View
    {
        Section
        {
            Image(uiImage: getProfilePictue())
            .resizable()
            .scaledToFit()
            .aspectRatio(contentMode: .fit)
            .frame(width: 150, height: 200)
            .cornerRadius(20)
            .accessibilityLabel("Profile Picture")
            .accessibilityIdentifier("profilePicture")
        }
    }
    
    var signinButton : some View
    {
        Section
        {
            Button(action: {
                print("sign in button tapped")
            }, label: {
                Text("Sign In")
                    .fontWeight(.bold)
                    .padding()
                    .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 0, idealHeight: 50, maxHeight: 50, alignment: .center)
            })
                .padding(.bottom, 0)
                .accessibilityLabel("Sign In")
                .accessibilityIdentifier("signIn")
                .buttonStyle(CustomButtonStyle())
        }
    }
    
    func getProfilePictue() -> UIImage {
        
        if let profilePictureData = viewModel.getUserProfilePicture()
        {
            return UIImage(data: profilePictureData)!
        }
       return UIImage(named: "defaultImage.png")!
    }

}
