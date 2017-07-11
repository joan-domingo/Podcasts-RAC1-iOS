//
//  PodcastTableViewCell.swift
//  Random1
//
//  Created by Joan Domingo Sallent on 27/03/2017.
//
//

import Kingfisher

class PodcastTableViewCell: UITableViewCell {

    //MARK: Properties
    
    var iconPhoto: UIImageView!
    var titleLabel: UILabel!
    
    var cellHeight = CGFloat()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        iconPhoto = UIImageView()
        iconPhoto.frame = CGRect(x: 20, y: 10, width: 50, height: 50)
        iconPhoto.layer.borderWidth = 1
        iconPhoto.layer.masksToBounds = false
        iconPhoto.layer.borderColor = UIColor.red.cgColor
        iconPhoto.layer.cornerRadius = iconPhoto.frame.height/2
        iconPhoto.clipsToBounds = true
        contentView.addSubview(iconPhoto)
        
        titleLabel = UILabel()
        titleLabel.frame = CGRect(x: iconPhoto.frame.origin.x + iconPhoto.frame.width + 10 , y: 10, width: contentView.frame.width - iconPhoto.frame.width - 10, height: iconPhoto.frame.height)
        titleLabel.textColor = UIColor.black
        contentView.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
