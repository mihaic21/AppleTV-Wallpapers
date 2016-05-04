//
//  ViewController.swift
//  SpartanWallpapers
//
//  Created by Mihai Costiug on 28/04/16.
//  Copyright © 2016 Mihai Costiug. All rights reserved.
//

import UIKit
import AVFoundation

enum ImageTypes: CustomStringConvertible {
    case Spartan
    case Easter
    
    var description: String {
        get {
            switch self {
            case .Spartan:
                return "spartan"
            case .Easter:
                return "easter"
            }
        }
    }
}

class ViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer?
    var timer: NSTimer?
    
    @IBOutlet weak var imageButton: UIButton!
    
    var currentImageType: ImageTypes = .Spartan {
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
//        self.switchImage()
        self.playSound()
    }
    
    func playSound() {
        self.audioPlayer?.prepareToPlay()
        self.audioPlayer?.play()
    }
    
    func switchImage() {
        switch self.currentImageType {
        case .Spartan:
            self.currentImageType = .Easter
        case .Easter:
            self.currentImageType = .Spartan
        }
    }
}

