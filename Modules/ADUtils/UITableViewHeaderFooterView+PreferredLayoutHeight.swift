//
//  UITableViewHeaderFooterView+PreferredLayoutHeight.swift
//  ADUtils
//
//  Created by Denis Poifol on 05/04/2019.
//

import Foundation
import UIKit

extension UITableViewHeaderFooterView {

    /**
     Provides the preferred layout height for the table view headerFooter, this is the smallest height the view and its content can fit. You should populate the view before calling this method.

     - parameter fittingWidth: The biggest width the view can get
     */
    public func ad_preferredContentViewLayoutHeight(fittingWidth: CGFloat) -> CGFloat {
        return contentView.ad_preferredLayoutHeight(fittingWidth: fittingWidth)
    }
}
