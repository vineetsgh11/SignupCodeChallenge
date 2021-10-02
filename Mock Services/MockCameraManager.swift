//
//  MockCameraManager.swift
//  SignupCodeChallenge
//
//  Created by Vineet Singh on 10/1/21.
//

import Foundation


class MockCameraManager : CameraManagerProtocol {
    
    var requestPermissionCalled = false
    
    var accessGranted = false


    func requestPermission(completion : @escaping (Bool) -> Void) {
        
        requestPermissionCalled = true
        completion(accessGranted)
    }
}
