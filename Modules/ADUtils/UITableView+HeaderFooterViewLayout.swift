//
//  UITableView+HeaderFooterViewLayout.swift
//  ADUtils
//
//  Created by Pierre Felgines on 04/05/2020.
//

import Foundation
import UIKit

public extension UITableView {

    /**
     Layout the footer view before displaying it.
     This ensures the footerView has a correct frame when visible.
     - parameter view: The view that is displayed below the table's content
     - parameter computationType: The computation type used to size the view
     */
    func ad_setAndLayoutTableFooterView(_ view: UIView?,
                                        computationType: LayoutComputationType = .layoutEngine) {
        tableFooterView = view
        guard let view = view else { return }
        updateFrame(of: view, with: computationType)
        self.tableFooterView = view
    }

    /**
    Layout the header view before displaying it.
    This ensures the header view has a correct frame when visible.
    - parameter view: The view that is displayed above the table's content
    - parameter computationType: The computation type used to size the view
    */
    func ad_setAndLayoutTableHeaderView(_ view: UIView?,
                                        computationType: LayoutComputationType = .layoutEngine) {
        tableHeaderView = view
        guard let view = view else { return }
        updateFrame(of: view, with: computationType)
        self.tableHeaderView = view
    }

    // MARK: - Private

    private func updateFrame(of view: UIView,
                             with computationType: LayoutComputationType = .layoutEngine) {
        let targetWidth = bounds.width
        let height = view.ad_preferredLayoutHeight(
            fittingWidth: targetWidth,
            computationType: computationType
        )
        var frame = view.frame
        frame.size = CGSize(width: targetWidth, height: height)
        view.frame = frame
    }
}
