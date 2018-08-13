//
//  GameLayout.swift
//  colorMagic
//
//  Created by Anthony on 5/12/2017.
//  Copyright © 2017 Antman.Tech. All rights reserved.
//

import UIKit

protocol GameLayoutDelegate: class {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat
}

class GameLayout: UICollectionViewLayout {

    weak var delegate: GameLayoutDelegate!

    fileprivate var numberOfColumns = 4
    fileprivate var cellPadding: CGFloat = 6

    fileprivate var cache = [UICollectionViewLayoutAttributes]()

    fileprivate var contentHeight: CGFloat = 0

    fileprivate var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }

    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }

}
