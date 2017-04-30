//
//  CustomAVPlayerViewController.swift
//  Random1
//
//  Created by Joan Domingo Sallent on 28.03.17.
//
//

import UIKit
import AVKit
import AVFoundation

class CustomAVPlayerViewController: AVPlayerViewController {
    
    var imageUrl: URL?
    var audioUrl: URL?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.player = AVPlayer(url: audioUrl!)
        self.player?.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
