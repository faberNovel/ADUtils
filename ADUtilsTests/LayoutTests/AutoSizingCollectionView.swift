//
//  AutoSizingCollectionView.swift
//  ADUtilsTests
//
//  Created by Samuel Gallet on 25/03/2020.
//

import UIKit

class AutoSizingCollectionView: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()
        invalidateIntrinsicContentSize()
    }

    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}
