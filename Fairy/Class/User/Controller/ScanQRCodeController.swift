//
//  ScanQRCodeController.swift
//  Fairy
//
//  Created by 丁鹏飞 on 2017/6/19.
//  Copyright © 2017年 丁鹏飞. All rights reserved.
//

import UIKit
import Photos
import AVFoundation

class ScanQRCodeController: UIViewController {
    
    private var captureSession = AVCaptureSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        checkStatus()
    }
    
    private func checkStatus() {
        let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        if status == AVAuthorizationStatus.authorized {
            showScanView()
            
        } else if (status == AVAuthorizationStatus.denied) {
            showAuthorizationStatusDeniedAlert(title: "没有访问权限")
            
        } else if (status == AVAuthorizationStatus.notDetermined) {
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (flag) in
                DispatchQueue.main.async {
                    flag ? self.showScanView() : ()
                }
            })
        }
    }
    
    private func showScanView() {
        captureSession.sessionPreset = AVCaptureSession.Preset.high
        
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        let deviceInput = try? AVCaptureDeviceInput(device: captureDevice!)
        if captureSession.canAddInput(deviceInput!) {
            captureSession.addInput(deviceInput!)
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
//        metadataOutput.setMetadataObjectsDelegate(self as! AVCaptureMetadataOutputObjectsDelegate, queue: DispatchQueue.global())
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
        }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.bounds
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
