//
//  CountryTableViewCell.swift
//  feeApp
//
//  Created by  mac on 3/15/20.
//  Copyright © 2020 Vladimir. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var flag: UIImageView!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var countryTip: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

struct Countries {
    let flag: String
    let name: String
    let tip: String
}
