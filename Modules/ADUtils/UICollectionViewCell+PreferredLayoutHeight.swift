//
//  UICollectionViewCell+PreferredLayoutHeight.swift
//  ADUtils
//
//  Created by Pierre Felgines on 21/09/2018.
//

import Foundation
import UIKit

public extension UICollectionViewCell {

    /**
     Provides the preferred layout height for the collection view cell, this is the smallest height the view and its content can fit. You should populate the view before calling this method.

     - parameter fittingWidth: The biggest width the view can get
     */
    public func ad_preferredCellLayoutHeight(fittingWidth: CGFloat) -> CGFloat {
        return contentView.ad_preferredLayoutHeight(fittingWidth: fittingWidth)
    }
}
