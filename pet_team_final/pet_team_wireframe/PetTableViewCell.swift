//
//  PetTableViewCell.swift
//  pet_team_wireframe
//
//  Created by Mathew Perez on 11/19/18.
//  Copyright © 2018 Pet Team. All rights reserved.
//

import UIKit

class PetTableViewCell: UITableViewCell {
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellName: UILabel!
    @IBOutlet weak var cellBreed: UILabel!
    @IBOutlet weak var cellAge: UILabel!
    @IBOutlet weak var cellGender: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
