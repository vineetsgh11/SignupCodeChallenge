//
//  CameraManager.swift
//  SignupCodeChallenge
//
//  Created by Vineet Singh on 10/1/21.
//

import Foundation
import AVFoundation

protocol CameraManagerProtocol {
    func requestPermission(completion : @escaping (Bool) -> Void)
}

class CameraManager : CameraManagerProtocol {
    @Published var permissionGranted = false
    
    func requestPermission(completion : @escaping (Bool) -> Void) {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: {accessGranted in
            DispatchQueue.main.async {
               completion(accessGranted)
            }
        })
    }
}
