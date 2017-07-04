//
//  ProgramTableViewCell.swift
//  Random1
//
//  Created by Joan Domingo Sallent on 22/03/2017.
//
//

import UIKit

class ProgramTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var program: Program? {
        didSet {
            // TODO
            nameLabel.text = program?.name
        }
    }
}
