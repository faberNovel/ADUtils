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

     - parameter computationType: The layout computation type to use
     */
    @available(*, deprecated, message: "Use `ad_preferredCellLayoutSize(fittingWidth:)` directly instead")
    func ad_preferredCellLayoutHeight(fittingWidth: CGFloat,
                                      computationType: LayoutComputationType = .layoutEngine) -> CGFloat {
        return ad_preferredCellLayoutSize(fittingWidth: fittingWidth, computationType: computationType).height
    }

    /**
     Provides the preferred layout size for the collection view cell, this is the smallest size the view and its content can fit. You should populate the view before calling this method.

     - parameter fittingWidth: The biggest width the view can get

     - parameter computationType: The layout computation type to use
     */
    func ad_preferredCellLayoutSize(fittingWidth: CGFloat,
                                    computationType: LayoutComputationType = .layoutEngine) -> CGSize {
        return contentView.ad_preferredLayoutSize(fittingWidth: fittingWidth, computationType: computationType)
    }

    /**
     Provides the preferred layout size for the collection view cell, this is the smallest size the view and its content can fit. You should populate the view before calling this method.

     - parameter fittingHeight: The biggest height the view can get

     - parameter computationType: The layout computation type to use
     */
    func ad_preferredCellLayoutSize(fittingHeight: CGFloat,
                                    computationType: LayoutComputationType = .layoutEngine) -> CGSize {
        return contentView.ad_preferredLayoutSize(fittingHeight: fittingHeight, computationType: computationType)
    }
}
