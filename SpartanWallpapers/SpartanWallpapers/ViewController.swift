//
//  ViewController.swift
//  SpartanWallpapers
//
//  Created by Mihai Costiug on 28/04/16.
//  Copyright © 2016 Mihai Costiug. All rights reserved.
//

import UIKit
import AVFoundation

enum ImageTypes: Int, CustomStringConvertible {
    case WallPaper12 = 0
    case Easter
    case WallPaper1
    case WallPaper2
    case WallPaper3
    case WallPaper4
    case WallPaper5
    case WallPaper6
    case WallPaper7
    case WallPaper8
    case WallPaper9
    case WallPaper10
    case WallPaper11
    
    var description: String {
        get {
            switch self {
            case .WallPaper8:
                return "spartan"
            case .Easter:
                return "spartan"
            case .WallPaper1:
                return "1"
            case .WallPaper2:
                return "2"
            case .WallPaper3:
                return "3"
            case .WallPaper4:
                return "4"
            case .WallPaper5:
                return "5"
            case .WallPaper6:
                return "6"
            case .WallPaper7:
                return "7"
                
            default:
                return "spartan"
            }
        }
    }
}

class ViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer?
    var timer: NSTimer?
    var randomNumber: NSInteger?
    
    @IBOutlet weak var imageButton: UIButton!
    
    var currentImageType: ImageTypes = .WallPaper12 {
        didSet {
            if let image = UIImage(named: currentImageType.description) {
                self.imageButton.setImage(image, forState: .Normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let filePath = NSBundle.mainBundle().pathForResource("sparta", ofType: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: filePath))
            } catch {
                print("Error getting audio file")
            }
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.playSound()
        self.timer = NSTimer.scheduledTimerWithTimeInterval(3600, target: self, selector: #selector(ViewController.playSound), userInfo: nil, repeats: true)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.timer?.invalidate()
    }

    
    @IBAction func buttonPressed(sender: UIButton) {
        self.switchImage()
        self.playSound()
    }
    
    func playSound() {
        self.audioPlayer?.prepareToPlay()
        self.audioPlayer?.play()
    }
    
    func switchImage() {
        let randomNumber = (drand48() * 10000) % 8 + 1
        print(NSString(format:"%", randomNumber))
        
        if let newImageType = ImageTypes(rawValue: Int(randomNumber)) {
            self.currentImageType = newImageType
        }
    }
}
