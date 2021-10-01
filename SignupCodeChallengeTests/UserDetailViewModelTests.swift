//
//  UserDetailViewModelTests.swift
//  SignupCodeChallengeTests
//
//  Created by Vineet Singh on 10/1/21.
//

import XCTest
@testable import SignupCodeChallenge

class UserDetailsViewModelTests: XCTestCase {
    
    var viewModel : UserDetailViewModel!
    var userManagerService : UserManagerService!


    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        try? super.setUpWithError()
        
        userManagerService = UserManagerService()
        viewModel = UserDetailViewModel(userManagerService: userManagerService)
    }

    func testUserIsNil() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        XCTAssertNil(userManagerService.getUser())
        XCTAssertNil(viewModel.getUserProfilePicture())
        XCTAssertTrue(viewModel.emailAddress.isEmpty)
        XCTAssertTrue(viewModel.websiteLink.isEmpty)
        XCTAssertTrue(viewModel.firstName.isEmpty)
        XCTAssertTrue(viewModel.headerText.isEmpty)

    }
    
    func testHeaderText_ShouldUpdateBBasedOnFirstName() {
        
        let user = getUser()
        userManagerService.UpdateUser(user: user)
        XCTAssertEqual("Hello, \(user.firstName)!", viewModel.headerText)
        
        let user1 = User(firstName: "", emailAddress: "abc@gmail.com", website: "abc.com", profilePictureData: nil)
        userManagerService.UpdateUser(user: user1)
        XCTAssertEqual("Hello!", viewModel.headerText)

    }
    
    func testValidUser_ShouldPopulateCorrectData() {
        
        let user = getUser()
        userManagerService.UpdateUser(user: user)
                
        XCTAssertNotNil(userManagerService.getUser())
        XCTAssertEqual("Hello, \(user.firstName)!", viewModel.headerText)
        XCTAssertEqual(user.emailAddress, viewModel.emailAddress)
        XCTAssertEqual(user.firstName, viewModel.firstName)
        XCTAssertEqual(user.website, viewModel.websiteLink)

    }
        
    func getUser() -> User
    {
        let imagedata = Data(base64Encoded: "iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4")

       return User(firstName: "test", emailAddress: "abc@gmail.com", website: "abc.com", profilePictureData: imagedata)

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.userManagerService = nil
        self.viewModel = nil
    }

}
