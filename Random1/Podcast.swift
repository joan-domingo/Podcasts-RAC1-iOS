//
//  Podcast.swift
//  Random1
//
//  Created by Joan Domingo Sallent on 27/03/2017.
//
//

import UIKit

class Podcast: NSObject {
    
    //MARK: Properties
    var title: String
    var imageUrl: URL
    var audioUrl: URL
    
    //MARK: Initialization
    
    init?(title: String, imageUrl: URL, audioUrl: String) {
        
        // The name must not be empty
        guard !title.isEmpty else {
            return nil
        }
        
        // Initialize stored properties.
        self.title = title
        self.imageUrl = imageUrl
        self.audioUrl = URL(string: audioUrl)!
    }
    
}
