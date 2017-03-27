//
//  PodcastTableViewCell.swift
//  Random1
//
//  Created by Joan Domingo Sallent on 27/03/2017.
//
//

import UIKit

class PodcastTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var podcastTitleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
