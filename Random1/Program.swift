//
//  Program.swift
//  Random1
//
//  Created by Joan Domingo Sallent on 22/03/2017.
//
//

import UIKit

class Program: NSObject {
    
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    
    //MARK: Initialization
    
    init?(name: String, photo: UIImage?) {
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.photo = photo
    }
    
}
