//
//  FloatingAccessorySeparatorItem.swift
//  FloatingAccessoryView
//
//  Created by Thomas Esterlin on 23/07/2021.
//

import Foundation

internal class FloatingAccessorySeparatorItem: UIView {

    override internal init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: - Private

    private func setup() {
        self.heightAnchor.constraint(equalToConstant: 1.0 / UIScreen.main.scale).isActive = true
    }
}
