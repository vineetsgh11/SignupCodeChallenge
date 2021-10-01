//
//  LoginViewModelTests.swift
//  SignupCodeChallengeTests
//
//  Created by Vineet Singh on 10/1/21.
//

import XCTest
@testable import SignupCodeChallenge

class SignupViewModelTests: XCTestCase {
    
    var viewModel : SignupViewModel!
    var autheticatonService : MockAuthenticationService!
    var userManagerService : UserManagerService!


    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        try? super.setUpWithError()
        
        userManagerService = UserManagerService()
        autheticatonService = MockAuthenticationService(userManagerService: userManagerService)
        viewModel = SignupViewModel(authenticatonService: autheticatonService, userManagerService: userManagerService)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        self.viewModel = nil
        self.autheticatonService = nil
        self.userManagerService =  nil
    }
    

    func testPasswordAndEmailEmpty_SubmitButtonDisabled() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        XCTAssertFalse(viewModel.enableSubmitButton)
    }
    
    func testEmailEmpty_SubmitButtonDisabled(){
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        viewModel.password = "abc"
        
        XCTAssertFalse(viewModel.enableSubmitButton)
    }
    
    func testValidEmail_PasswordEmpty_SubmitButtonDisabled() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        viewModel.emailAddress = "abc@gmail.com"
        
        XCTAssertFalse(viewModel.enableSubmitButton)
    }
    
    func testValidEmailAndPassword_SubmitButtonEnabled() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        viewModel.emailAddress = "abc@gmail.com"
        viewModel.password = "abc"

        XCTAssertTrue(viewModel.enableSubmitButton)
    }
    
    func testInvalidValidEmailAndPassword_SubmitButtonEnabled() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        viewModel.emailAddress = "abc@g"
        viewModel.password = "abc"

        XCTAssertTrue(viewModel.enableSubmitButton)
    }
    
    
    func testValidEmail_IsEmailValid_True() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        viewModel.emailAddress = "abc@gmail.com"

        XCTAssertTrue(viewModel.emailAddress.isValidEmail)
    }
    
    func testInValidWebsteUrl_IsWebsiteUrlValid_False() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        viewModel.website = "abc"

        XCTAssertFalse(viewModel.website.isValidURL)
    }
    
    func testValidWebsiteUrl_IsWebsiteUrlValid_True() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        viewModel.website = "abc.com"

        XCTAssertTrue(viewModel.website.isValidURL)
    }
    
    func testAuthenticateUser_ShouldCallAuthenticatonService_UserShouldbePopulated() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        viewModel.firstName = "Test User"
        viewModel.emailAddress = "test@gmail.com"
        viewModel.website = "abc.com"
        viewModel.profilePictureData = Data(base64Encoded: "iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4")
        viewModel.AuthenticateUser()
        

        XCTAssertTrue(autheticatonService.isAuthenticateUserCalled)
        XCTAssertTrue(viewModel.pushDetailView)
        XCTAssertNotNil(userManagerService.getUser())
        XCTAssertEqual(viewModel.firstName, userManagerService.getUser()!.firstName)
        XCTAssertEqual(viewModel.emailAddress, userManagerService.getUser()!.emailAddress)
        XCTAssertEqual(viewModel.website, userManagerService.getUser()!.website)
        XCTAssertEqual(viewModel.profilePictureData!, userManagerService.getUser()!.profilePictureData!)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
