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
    
    //MARK: Initialization
    
    init?(title: String) {
        
        // The name must not be empty
        guard !title.isEmpty else {
            return nil
        }
        
        // Initialize stored properties.
        self.title = title
    }
    
}
