//
//  RestaurantTableViewCell.swift
//  QuickFoodMenu
//
//  Created by maojie on 4/20/18.
//  Copyright © 2018 maojie. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet weak var restaurantTitleLabel: UILabel!
    @IBOutlet weak var restaurantImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupUI(viewModel: RestaurantListCellViewModel) {
        self.restaurantImageView.image = nil
        self.restaurantImageView.af_setImage(withURL: viewModel.coverImage.url)
        self.restaurantTitleLabel.text = viewModel.name
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

}
