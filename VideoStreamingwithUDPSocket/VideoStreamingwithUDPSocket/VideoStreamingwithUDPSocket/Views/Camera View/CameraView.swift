//
//  CameraView.swift
//  VideoStreamingwithUDPSocket
//
//  Created by vladikkk on 22/05/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI
import AVFoundation

struct CameraView : UIViewControllerRepresentable {
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<CameraView>) -> UIViewController {
        let controller = CameraViewController()
        return controller
    }
    
    
    func updateUIViewController(_ uiViewController: CameraView.UIViewControllerType, context: UIViewControllerRepresentableContext<CameraView>) { }
}

class CameraViewController : UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    var bufferSize: CGSize = .zero
    var rootLayer: CALayer! = nil
    
    private var detectionOverlay: CALayer! = nil
    
    private let session = AVCaptureSession()
    private let videoDataOutput = AVCaptureVideoDataOutput()
    private let videoOutputQueue = DispatchQueue(label: "Video_Output")
    
    private var previewLayer: AVCaptureVideoPreviewLayer! = nil
    
    private let streamingService = StreamingService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadCamera()
        self.session.startRunning()
    }
    
    func loadCamera() {
        
        guard let videoDevice = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back).devices.first else { return }
        
        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice) else {
            print("NO CAMERA DETECTED")
            return
        }
        
        // Begin session config
        self.session.beginConfiguration()
        self.session.sessionPreset = .hd1920x1080
        
        guard self.session.canAddInput(videoDeviceInput) else {
            NSLog("Could not add video device input to the session")
            self.session.commitConfiguration()
            return
        }
        // Add video input
        self.session.addInput(videoDeviceInput)
        
        if session.canAddOutput(self.videoDataOutput) {
            // Add a video data output
            self.session.addOutput(videoDataOutput)
            videoDataOutput.alwaysDiscardsLateVideoFrames = true
            videoDataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32BGRA)]
            videoDataOutput.setSampleBufferDelegate(self, queue: self.videoOutputQueue)
        } else {
            NSLog("Could not add video data output to the session")
            session.commitConfiguration()
            return
        }
        
        guard let captureConnection = videoDataOutput.connection(with: .video) else { return }
        
        // Always process the frames
        captureConnection.isEnabled = true
        
        do {
            try videoDevice.lockForConfiguration()
            
            let dimensions = CMVideoFormatDescriptionGetDimensions((videoDevice.activeFormat.formatDescription))
            // Read frame dimensions
            self.bufferSize.width = CGFloat(dimensions.width)
            self.bufferSize.height = CGFloat(dimensions.height)
            
            videoDevice.unlockForConfiguration()
        } catch {
            NSLog(error.localizedDescription)
        }
        
        // Save session config
        session.commitConfiguration()
        
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        rootLayer = view.layer
        previewLayer.frame = rootLayer.bounds
        rootLayer.addSublayer(previewLayer)
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // Get buffer with image data
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            NSLog("Error: Failed to get image buffer->\(#line)")
            
            return
        }
        
        // Lock the base address of the pixel buffer
        CVPixelBufferLockBaseAddress(imageBuffer, CVPixelBufferLockFlags(rawValue: 0))
        
        // Get the base address of the pixel buffer
        guard let baseAddress = CVPixelBufferGetBaseAddress(imageBuffer) else {
            NSLog("Error: Source buffer error->\(#line)")
            
            return
        }
        
        // Get the number of bytes per row for the pixel buffer
        let bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer)
        
        // Get the pixel buffer width and height
        let width = CVPixelBufferGetWidth(imageBuffer)
        let height = CVPixelBufferGetHeight(imageBuffer)
        
        // Create a device-dependent RGB color space
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        
        // Create a bitmap graphics context with the image buffer data
        guard let context = CGContext(data: baseAddress, width: width, height: height, bitsPerComponent: 5, bytesPerRow: bytesPerRow, space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue) else {
            NSLog("Error: Failed to create bitmap graphics context->\(#line)")
            
            return
        }
        
        // Create a Quartz image from the pixel data in the bitmap graphics context
        guard let quartzImage = context.makeImage() else {
            NSLog("Error: Failed to create quartz image->\(#line)")
            
            return
        }
        
        // Unlock the pixel buffer
        CVPixelBufferUnlockBaseAddress(imageBuffer, CVPixelBufferLockFlags(rawValue: 0))
        
        // Create a UIImage using quartz image
        let uiImage = UIImage(cgImage: quartzImage)
        
        // Get compressed jpeg data of uiImage
        guard let jpedgData = uiImage.jpegData(compressionQuality: 0.5) else {
            NSLog("Error: Failed to get jpeg data->\(#line)")
            
            return
        }
        
        self.getBase64Image(data: jpedgData)
        
        self.streamingService.sendString("\n ~~~~~ END ~~~~~ \n")
    }
    
    private func getBase64Image(data: Data) {
        let base64String = data.base64EncodedString(options: .lineLength64Characters)
        
        self.streamingService.sendString(base64String)
    }
}
