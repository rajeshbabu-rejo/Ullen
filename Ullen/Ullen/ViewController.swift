//
//  ViewController.swift
//  Ullen
//
//  Created by Rajesh Babu on 17/02/23.
//

import UIKit
import AVFoundation
import Vision

class ViewController: UIViewController {
    // Variables
    private var drawings: [CAShapeLayer] = []
    private let videoDataOutput = AVCaptureVideoDataOutput()
    private let captureSession = AVCaptureSession()
    private lazy var previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    var cameraCaptureOutput : AVCapturePhotoOutput?
    // Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCameraInput()
        showCameraFeed()
        getCameraFrames()
        captureSession.startRunning()
        // Do any additional setup after loading the view.
//        let button = UIButton(type: .custom)
//            button.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
//            button.layer.cornerRadius = 0.5 * button.bounds.size.width
//            button.clipsToBounds = true
//            button.setImage(UIImage(named:"thumbsUp.png"), for: .normal)
//            button.addTarget(self, action: #selector(thumbsUpButtonPressed), for: .touchUpInside)
//            view.addSubview(button)
    }
    func displayCapturedPhoto(capturedPhoto : UIImage) {
        
        let imagePreviewViewController = storyboard?.instantiateViewController(withIdentifier: "ImagePreviewViewController") as! ImagePreviewViewController
        imagePreviewViewController.capturedImage = capturedPhoto
        navigationController?.pushViewController(imagePreviewViewController, animated: true)
    }
    
//    @objc func thumbsUpButtonPressed() {
//        let settings = AVCapturePhotoSettings()
//        settings.flashMode = .auto
//        cameraCaptureOutput?.capturePhoto(with: settings, delegate: self)
//    }
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        previewLayer.frame = view.frame
        
    }
    // functions
    @IBAction func takePicture(_ sender: Any) {
        takePicture()
    }
    private func addCameraInput() {
        guard let device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInTrueDepthCamera, .builtInDualCamera, .builtInWideAngleCamera], mediaType: .video, position: .front).devices.first else {
            fatalError("Please do not use simulator, instead use a real device")
        }
        let cameraInput = try! AVCaptureDeviceInput(device: device)
        captureSession.addInput(cameraInput)
        cameraCaptureOutput = AVCapturePhotoOutput()
        captureSession.addOutput(cameraCaptureOutput!)
    }
    func takePicture() {
        let settings = AVCapturePhotoSettings()
        settings.flashMode = .auto
        cameraCaptureOutput?.capturePhoto(with: settings, delegate: self)
    }
    private func showCameraFeed() {
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
    }
    private func getCameraFrames() {
        videoDataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString): NSNumber(value: kCVPixelFormatType_32BGRA)] as [String:Any]
        videoDataOutput.alwaysDiscardsLateVideoFrames = true
        videoDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label:"camera frame processing"))
        captureSession.addOutput(videoDataOutput)
       
        guard let connection = videoDataOutput.connection(with: .video), connection.isVideoOrientationSupported else {
            return
        }
        connection.videoOrientation = .portrait
    }
    private func detectFace(image:CVPixelBuffer){
        let faceDetectionRequest = VNDetectFaceLandmarksRequest {VNRequest, error in
            DispatchQueue.main.async {
                if let results = VNRequest.results as? [VNFaceObservation], results.count > 0  {
                    //print("Detected \(results.count) number of faces")
                    self.handleFaceDetectionResults(observedFaces: results)
                } else {
                   // print("no face detected")
                    self.clearDrawings()
                }
            }
        }
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: image, orientation: .leftMirrored, options: [:])
        try? imageRequestHandler.perform([faceDetectionRequest])
    }
    private func handleFaceDetectionResults(observedFaces: [VNFaceObservation]) {
        clearDrawings()
        let faceBoundingBoxes:[CAShapeLayer] = observedFaces.map({ (observedFace: VNFaceObservation) -> CAShapeLayer in let faceBoundingBoxOnscreen = previewLayer.layerRectConverted(fromMetadataOutputRect: observedFace.boundingBox)
            let faceBoundingBoxPath = CGPath(rect: faceBoundingBoxOnscreen, transform: nil)
            let faceBoundingBoxShape = CAShapeLayer()
            faceBoundingBoxShape.path = faceBoundingBoxPath
            faceBoundingBoxShape.fillColor = UIColor.clear.cgColor
            faceBoundingBoxShape.strokeColor = UIColor.green.cgColor
            //observedFaces.count
            return faceBoundingBoxShape
        })
        faceBoundingBoxes.forEach{ faceBoundingBox in view.layer.addSublayer(faceBoundingBox)
            drawings = faceBoundingBoxes
        }
    }
    private func clearDrawings() {
        drawings.forEach({drawing in drawing.removeFromSuperlayer()})
    }
}
    // extension view controller
    extension ViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
        func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
            guard let frame = CMSampleBufferGetImageBuffer(sampleBuffer) else {
                debugPrint("unable to get image from sample buffer")
                return
            }
            detectFace(image: frame)
        }
    }
extension ViewController : AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        
        if let unwrappedError = error {
            print(unwrappedError.localizedDescription)
        } else {
            
            if let sampleBuffer = photoSampleBuffer, let dataImage =
                AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: sampleBuffer, previewPhotoSampleBuffer: previewPhotoSampleBuffer) {
                
                if let finalImage = UIImage(data: dataImage) {
                    
                    displayCapturedPhoto(capturedPhoto: finalImage)
                }
            }
        }
    }
}
