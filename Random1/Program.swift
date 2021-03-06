//
//  Program.swift
//  Random1
//
//  Created by Joan Domingo Sallent on 22/03/2017.
//
//

import Foundation

class Program: NSObject {
    
    //MARK: Properties
    var id: String
    var name: String
    var imageUrl: URL
    var active: Bool
    
    //MARK: Initialization
    
    init?(id: String, name: String, imageUrl: String, active: Bool) {
        
        // The id must not be empty
        guard !id.isEmpty else {
            return nil
        }
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // Initialize stored properties.
        self.id = id
        self.name = name
        self.imageUrl = URL(string: imageUrl)!
        self.active = active
    }
    
}
