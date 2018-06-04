//
//  RestaurantListViewController.swift
//  QuickFoodMenu
//
//  Created by maojie on 4/20/18.
//  Copyright © 2018 maojie. All rights reserved.
//

import UIKit
import AlamofireImage

class RestaurantListViewController: UITableViewController {
    lazy var viewModel: RestaurantListViewModel = {
        return RestaurantListViewModel()
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()
        initVM()
        viewModel.fetchRestaurantData()
    }

    func initVM() {
        viewModel.updateLoadingStatus = {


        }
        viewModel.reloadTableViewClosure = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCellReuseID", for: indexPath)

        if let cell = cell  as? RestaurantTableViewCell {
            let cellVM = viewModel.getCellViewModel(at: indexPath)
            cell.restaurantImageView.image = nil
            cell.restaurantImageView.af_setImage(withURL: cellVM.coverImage.url)
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        return (SCREEN_WIDTH-36) / CGFloat(cellVM.coverImage.width)
            * CGFloat(cellVM.coverImage.height)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let targetVC = storyboard.instantiateViewController(withIdentifier: "MenuPicCollectionVCID") as! MenuPicCollectionViewController
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        targetVC.dishes = cellVM.images
        self.navigationController?.pushViewController(targetVC, animated: true)
    }
}
