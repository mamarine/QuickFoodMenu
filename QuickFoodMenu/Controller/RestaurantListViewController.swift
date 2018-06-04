//
//  RestaurantTableViewController.swift
//  QuickFoodMenu
//
//  Created by maojie on 4/20/18.
//  Copyright © 2018 maojie. All rights reserved.
//

import UIKit
import AlamofireImage

class RestaurantListViewController: UITableViewController {
    var restaurants = [Restaurant]()//RestaurantDataManagerV1.shareInstance.getRestaurants()
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCellReuseID", for: indexPath)

        if let cell = cell  as? RestaurantTableViewCell {
            cell.restaurantImageView.image = nil
            cell.restaurantImageView.af_setImage(withURL: restaurants[indexPath.row].coverImage.url)
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (SCREEN_WIDTH-36) / CGFloat(restaurants[indexPath.row].coverImage.width)
            * CGFloat(restaurants[indexPath.row].coverImage.height)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let targetVC = storyboard.instantiateViewController(withIdentifier: "MenuPicCollectionVCID") as! MenuPicCollectionViewController
        targetVC.dishes = restaurants[indexPath.row].images
        self.navigationController?.pushViewController(targetVC, animated: true)
    }
}
