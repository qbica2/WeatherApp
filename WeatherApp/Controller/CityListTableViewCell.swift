//
//  CityListTableViewCell.swift
//  WeatherApp
//
//  Created by Mehmet Kubilay Akdemir on 1.02.2023.
//

import UIKit

class CityListTableViewCell: UITableViewCell {

    @IBOutlet weak var cityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
