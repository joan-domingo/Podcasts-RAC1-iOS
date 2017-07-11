//
//  Podcast.swift
//  Random1
//
//  Created by Joan Domingo Sallent on 27/03/2017.
//
//

import Foundation

class Podcast: NSObject {
    
    //MARK: Properties
    var id: String
    var title: String
    var imageUrl: URL
    var audioUrl: URL
    
    //MARK: Initialization
    
    init(id: String, title: String, imageUrl: URL, audioUrl: String) {
        self.id = id
        self.title = title
        self.imageUrl = imageUrl
        self.audioUrl = URL(string: audioUrl)!
    }
    
}
