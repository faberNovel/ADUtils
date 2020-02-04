//
//  UITableViewCell+PreferredLayoutHeight.swift
//  ADUtils
//
//  Created by Pierre Felgines on 18/04/2018.
//

import Foundation
import UIKit

public extension UITableViewCell {

    /**
     Provides the preferred layout height for the table view cell, this is the smallest height the view and its content can fit. You should populate the view before calling this method.

     - parameter fittingWidth: The biggest width the view can get
     */
    func ad_preferredCellLayoutHeight(fittingWidth: CGFloat) -> CGFloat {
        return contentView.ad_preferredLayoutHeight(fittingWidth: fittingWidth)
    }
}
