//
//  MasonryLayout.swift
//  QuickFoodMenu
//
//  Created by maojie on 4/26/18.
//  Copyright © 2018 maojie. All rights reserved.
//

import UIKit

protocol MasonryLayoutDelegate: AnyObject {
    func collectionView(_ collectionView:UICollectionView, sizeForCellAtIndexPath indexPath:IndexPath) -> CGSize
}

class MasonryLayout: UICollectionViewFlowLayout {
    weak var delegate: MasonryLayoutDelegate?
    private var numberOfColumns = 2
    private var cellPadding: CGFloat = 3
    private var cache = [UICollectionViewLayoutAttributes]()
    private var contentHeight: CGFloat = 0

    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }

    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }

    override func prepare() {
        guard cache.isEmpty == true, let collectionView = collectionView else {
            return
        }

        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffsets = Array<CGFloat>()
        for column in 0..<numberOfColumns {
            xOffsets.append(CGFloat(column)*columnWidth)
        }
        var column = 0
        var yOffsets = Array<CGFloat>(repeating:0, count:numberOfColumns)

        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let imageSize = delegate?.collectionView(collectionView, sizeForCellAtIndexPath: indexPath) ?? CGSize(width: 0, height: 0)
            let height = imageSize.height * columnWidth / imageSize.width
            let frame = CGRect(x: xOffsets[column], y: yOffsets[column], width: columnWidth, height: height)
            let insetFrame = frame.insetBy(dx: cellPadding/2, dy: cellPadding/2)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            contentHeight = max(contentHeight,frame.maxY)
            yOffsets[column] = yOffsets[column] + height
            column = yOffsets[0] > yOffsets[1] ? 1:0
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cache.filter { $0.frame.intersects(rect)}
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}
