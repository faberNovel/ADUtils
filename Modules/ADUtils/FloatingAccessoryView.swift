//
//  FloatingAccessoryView.swift
//  FloatingAccessoryView
//
//  Created by Thomas Esterlin on 16/07/2021.
//

import Foundation

/*
 * Usage example:
 *
 * To create a FloatingAccessoryView :
 *      let accessoryView = FloatingAccessoryView()
 *
 * To create items :
 *      let item1 = FloatingAccessoryButtonItem(systemName: "touchid")
 *      let item2 = FloatingAccessoryButtonItem(systemName: "function")
 *      let item3 = FloatingAccessoryButtonItem(systemName: "figure.wave")
 *
 * To add the items to the view :
 *      accessoryView.addItem(item1)
 *      accessoryView.addItem(item2)
 *      accessoryView.addItem(item3)
 *
 * To override tintColor of every item :
 *      accessoryView.tintColor = .green
 *
 * To override tintColor of one of the items :
 *      item1.tintColor = .systemRed
 *
 * To add a target to one of the item :
 *      item2.addTarget(self, action: #selector(myMethod), for: .touchUpInside)
 *
 * To change the view's separators' tint color :
 *      accessoryView.borderTintColor = .black
 *
 */

@available(iOS 13.0, *)
private enum Constants {
    static let stackViewWidth = 48.0
    static let paddingTopBottom: CGFloat = 4.0
    static let collectionViewBorderRadius = 8.0
}

@available(iOS 13.0, *)
private enum Colors {
    static var initialTintColor: UIColor {
        return UIColor { (traits) -> UIColor in
            return traits.userInterfaceStyle == .dark ?
                .white :
                .systemBlue
        }
    }
    static var initialBorder: UIColor {
        return UIColor { (traits) -> UIColor in
            return traits.userInterfaceStyle == .dark ?
                UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 1.0) :
                .separator
        }
    }
    static var initialBackground: UIColor {
        return UIColor { (traits) -> UIColor in
            return traits.userInterfaceStyle == .dark ?
                UIColor(red: 58 / 255, green: 59 / 255, blue: 61 / 255, alpha: 1.0) :
                UIColor(red: 254 / 255, green: 252 / 255, blue: 247 / 255, alpha: 1.0)
        }
    }
}

@available(iOS 13.0, *)
public class FloatingAccessoryView: UIView {

    /**
     The view's separators' tint color.

     # Example #
     ```
     floatingAccessoryView.borderTintColor = UIColor.red
     ```
     */
    public var borderTintColor: UIColor = Colors.initialBorder {
        didSet {
            for separator in separators.values {
                separator.backgroundColor = borderTintColor
            }
        }
    }

    override public var backgroundColor: UIColor? {
        get {
            return stackView.backgroundColor
        }
        set {
            stackView.backgroundColor = newValue
        }
    }

    private var stackView = UIStackView()
    private var buttonViews: [FloatingAccessoryButtonItem: UIView] = [:]
    private var separators: [FloatingAccessoryButtonItem: FloatingAccessorySeparatorItem] = [:]

    // MARK: - Lifecycle

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: - Public

    /**
     This method adds an item to the view.

     This method adds an item to the view. Separators are automatically added if needed.

     - parameter item: The item to add to the view.

     # Notes: #
     1. Item must be **FloatingAccessoryButtonItem** type

     # Example #
    ```
     let accessoryView = FloatingAccessoryView()
     let item = FloatingAccessoryButtonItem()
     accessoryView.addItem(item)
     ```
    */
    public func addItem(_ item: FloatingAccessoryButtonItem) {
        if buttonViews.keys.contains(item) {
            return
        }
        let separatorItem = FloatingAccessorySeparatorItem()
        separators[item] = separatorItem
        separatorItem.backgroundColor = borderTintColor
        let view = UIView()
        view.addSubview(item)
        item.ad_pinToSuperview()
        buttonViews[item] = view
        if !stackView.subviews.isEmpty {
            stackView.addArrangedSubview(separatorItem)
        }
        stackView.addArrangedSubview(view)
    }

    /**
     This method removes an item from the view.

     This method removes an item from the view. Separators are automatically removed or added if needed.

     - parameter item: The item to remove from the view.

     # Notes: #
     1. Item must be **FloatingAccessoryButtonItem** type

     # Example #
     ```
     let accessoryView = FloatingAccessoryView()
     let item = FloatingAccessoryButtonItem()
     accessoryView.addItem(item)
     accessoryView.removeItem(item)
     ```
     */
    public func removeItem(_ item: FloatingAccessoryButtonItem) {
        if let separator = separators[item] {
            separator.removeFromSuperview()
            separators.removeValue(forKey: item)
        }
        if let buttonView = buttonViews[item] {
            buttonViews.removeValue(forKey: item)
            item.removeFromSuperview()
            buttonView.removeFromSuperview()
        }
        removeFirstItemBorderIfNeeded()
    }

    // MARK: - Private

    private func setup() {
        backgroundColor = .clear
        tintColor = Colors.initialTintColor
        stackView.layer.cornerRadius = CGFloat(Constants.collectionViewBorderRadius)
        stackView.axis  = .vertical
        stackView.distribution  = .fill
        stackView.alignment = .fill
        stackView.spacing   = 0.0

        let blurEffectView = UIVisualEffectView(effect: nil)
        blurEffectView.layer.cornerRadius = CGFloat(Constants.collectionViewBorderRadius)
        blurEffectView.clipsToBounds = true

        self.addSubview(blurEffectView)
        blurEffectView.ad_pinToSuperview()

        let blurEffect = UIBlurEffect(style: .systemMaterial)
        blurEffectView.effect = blurEffect

        blurEffectView.contentView.addSubview(stackView)
        stackView.ad_pinToSuperview()

        setupShadow()
    }

    private func setupShadow() {
        let shadowView = UIView()
        shadowView.backgroundColor = .clear
        layer.shadowOpacity = 0.2
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = CGFloat(Constants.collectionViewBorderRadius)
        insertSubview(shadowView, at: 0)
        shadowView.ad_pinToSuperview()
    }

    private func removeFirstItemBorderIfNeeded() {
        if let firstStackViewSubview = stackView.subviews.first as? FloatingAccessorySeparatorItem,
           separators.values.contains(firstStackViewSubview) {
            firstStackViewSubview.removeFromSuperview()
        }
    }

}
