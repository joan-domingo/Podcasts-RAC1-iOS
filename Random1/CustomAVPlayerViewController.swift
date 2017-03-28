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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let albumArt = UIImageView()
        //albumArt.kf.setImage(with: imageUrl!)
        self.contentOverlayView?.addSubview(albumArt)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
