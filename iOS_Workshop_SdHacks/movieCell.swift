//
//  movieCell.swift
//  iOS_Workshop_SdHacks
//
//  Created by Shixuan Li on 10/21/17.
//  Copyright © 2017 Shixuan Li. All rights reserved.
//

import UIKit

class movieCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var movieImageView: UIImageView!
    
    var movie: NSDictionary? {
        didSet {
            // updaat UI elements once you have the data ready
            self.titleLabel.text = self.movie?["title"] as? String
            // update image
            if let url = URL(string: "http://google.com/dummy.png") {
                if let data = try? Data(contentsOf: url) {
                    self.imageView?.image = UIImage(data: data)
                    
                }
            }
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
