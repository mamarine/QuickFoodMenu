//
//  MenuPicCollectionViewController.swift
//  QuickFoodMenu
//
//  Created by maojie on 4/25/18.
//  Copyright © 2018 maojie. All rights reserved.
//

import UIKit

class MenuPicCollectionViewController: UICollectionViewController {

    private let reuseIdentifier = "MENUPICCELLID"
    // MARK: temp dummy code
    var dishes = Array<NetworkImage>()

    override func viewDidLoad() {
        super.viewDidLoad()
        if let layout = collectionView?.collectionViewLayout as? MasonryLayout {
            layout.delegate = self
        }

        collectionView?.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dishes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MenuPicCollectionViewCell
        cell.imageView.af_setImage(withURL: dishes[indexPath.item].url)

        return cell
    }
}

extension MenuPicCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: itemSize)
    }
}

extension MenuPicCollectionViewController: MasonryLayoutDelegate {
    func collectionView(_ collectionView:UICollectionView, sizeForCellAtIndexPath indexPath:IndexPath) -> CGSize {
        return CGSize(width: CGFloat(dishes[indexPath.item].width), height: CGFloat(dishes[indexPath.item].height))
    }
}
