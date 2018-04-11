//
//  CoreMLGameViewController.swift
//  Leocha-IOS
//
//  Created by Marion FANJAUD on 08/04/2018.
//  Copyright © 2018 Marion FANJAUD. All rights reserved.
//

import Foundation
import MobileCoreServices
import Vision
import CoreML
import AVKit
import AVFoundation

class CoreMLGameViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var objectLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    var cameraLayer: CALayer!
    var gameTimer: Timer!
    // Time remaining in the game : initialized to 120 so the game lasts 2 minute
    var timeRemaining = 120
    var currentScore = 0
    var highScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        viewSetup()
        cameraSetup()
        getHighScore()
    }
    
    
    @IBAction func startButtonTapped(_ sender: Any) {
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (gameTimer) in
           
            guard self.timeRemaining != 0 else {
                gameTimer.invalidate()
                self.endGame()
                return
            }
            
            self.timeRemaining -= 1
            self.timeLabel.text = "\(self.timeRemaining)"
        })
        
        startButton.isHidden = true
        skipButton.isHidden = false
        nextObject()
        
    }
    
    
    @IBAction func skipButtonTapped(_ sender: Any) {
        nextObject()
    }
    
    
    
    //MARK: - Basic UI settings
    
    func viewSetup(){
        let backgroundColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8)
        topView.backgroundColor = backgroundColor
        bottomView.backgroundColor = backgroundColor
        scoreLabel.text = "0"
        
    }
    
    //MARK: - Camera setup method
    
    func cameraSetup(){
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        
        let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)!
        let input = try! AVCaptureDeviceInput(device: backCamera)
        
        captureSession.addInput(input)
        
        cameraLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(cameraLayer)
        cameraLayer.frame = view.bounds
        view.bringSubview(toFront: topView)
        view.bringSubview(toFront: bottomView)
        
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self as AVCaptureVideoDataOutputSampleBufferDelegate, queue: DispatchQueue(label: "buffer delegate"))
        videoOutput.recommendedVideoSettings(forVideoCodecType: .jpeg, assetWriterOutputFileType: .mp4)
        
        captureSession.addOutput(videoOutput)
        captureSession.sessionPreset = .high
        captureSession.startRunning()
        
    }
    
    //MARK: - Object prediction method
    
    func predict(image: CGImage) {
        let model = try! VNCoreMLModel(for: Inceptionv3().model)
        let request = VNCoreMLRequest(model: model, completionHandler: results)
        let handler = VNSequenceRequestHandler()
        try! handler.perform([request], on: image)
    }
    
    func results(request: VNRequest, error: Error?) {
        guard let results = request.results as? [VNClassificationObservation] else {
            print("No result found")
            return
        }
        
        
        guard results.count != 0 else {
            print("No result found")
            return
        }
        
        let highestConfidenceResult = results.first!
        let identifier = highestConfidenceResult.identifier.contains(", ") ? String(describing: highestConfidenceResult.identifier.split(separator: ",").first!) : highestConfidenceResult.identifier
        
        if identifier == objectLabel.text! {
            currentScore += 1
            nextObject()
        }
    }
    
    
    //MARK: - Game track and play
    
    func getHighScore(){
        if let score = UserDefaults.standard.object(forKey: "highScore"){
            highscoreLabel.text = "\(score)"
            highScore = score as! Int
        } else {
            print("No highscore, setting to 0.")
            highscoreLabel.text = "0"
            highScore = 0
            setHighScore(score: 0)
        }
    }
    
    func setHighScore(score: Int){
        UserDefaults.standard.set(score, forKey: "highscore")
    }
    
    
    func endGame(){
        startButton.isHidden = false
        skipButton.isHidden = false
        objectLabel.text = "Game Over"
        
        if currentScore > highScore {
            setHighScore(score: currentScore)
            highscoreLabel.text = "\(currentScore)"
        }
        
        currentScore = 0
        timeRemaining = 120
    }
    
    func nextObject(){
        
        let allObjects = Objects().objectArray
        let randomObjectIndex = Int(arc4random_uniform(UInt32(allObjects.count)))
        let utterance = AVSpeechUtterance(string: allObjects[randomObjectIndex])
        let synth = AVSpeechSynthesizer()
        
        guard allObjects[randomObjectIndex] != objectLabel.text else { 
            nextObject()
            return
        }
        
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        synth.speak(utterance)
        
        objectLabel.text = allObjects[randomObjectIndex]
        scoreLabel.text = "\(currentScore)"
        
    }
}




extension CoreMLGameViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { fatalError("pixel buffer is nil") }
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        let context = CIContext(options: nil)
        
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else { fatalError("cg image") }
        let uiImage = UIImage(cgImage: cgImage, scale: 1.0, orientation: .leftMirrored)
        
        DispatchQueue.main.sync {
            predict(image: uiImage.cgImage!)
        }
    }
}
