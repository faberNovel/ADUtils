//
//  SideBarButtonItem.swift
//  FloatingAccessoryView
//
//  Created by Thomas Esterlin on 18/07/2021.
//

import Foundation

private enum Constants {
    static let horizontalPadding: CGFloat = 8.0
    static let verticalPadding: CGFloat = 8.0
}

public class FloatingAccessoryButtonItem: UIControl {

    private var button = UIButton()

    /**
     The item's button's image.

     The item's button's image. Setter and getter are available.
     */
    public var image: UIImage {
        get {
            return button.image(for: .normal) ?? UIImage()
        }
        set {
            self.button.setImage(newValue, for: .normal)
        }
    }

    public init(image: UIImage) {
        super.init(frame: CGRect.zero)
        setupButton(image: image)
    }

    @available(iOS 13, *)
    public init(systemName: String) {
        super.init(frame: CGRect.zero)
        setupButton(image: UIImage(systemName: systemName))
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        button.addTarget(target, action: action, for: controlEvents)
    }

    // MARK: - Private

    private func setupButton(image: UIImage?) {
        self.addConstraint(
            NSLayoutConstraint(
                item: button,
                attribute: .height,
                relatedBy: .equal,
                toItem: button,
                attribute: .width,
                multiplier: 1.0,
                constant: 1 / 1
            )
        )
        button.setTitle("", for: .normal)
        button.setImage(image, for: .normal)
        self.addSubview(button)
        button.ad_pinToSuperview(
            insets: UIEdgeInsets(
                horizontal: Constants.horizontalPadding,
                vertical: Constants.verticalPadding
            )
        )
    }
}
