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
 * Or :
 *      let items = [item1, item2, item3]
 *      accessoryView.addItems(contentOf: items)
 *
 * To remove an item from the view :
 *      accessoryView.removeItem(item1)
 *
 * To remove every item:
 *      accessoryView.removeAllItems
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
 *      accessoryView.separatorColor = .black
 *
 */

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
    static var initialSeparator: UIColor {
        return UIColor { (traits) -> UIColor in
            return traits.userInterfaceStyle == .dark ?
                UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 1.0) :
                .separator
        }
    }
}

@available(iOS 13.0, *)
public class FloatingAccessoryView: UIView {

    /**
     The view's separators' tint color.

     # Example #
     ```
     floatingAccessoryView.separatorColor = UIColor.red
     ```
     */
    public var separatorColor: UIColor = Colors.initialSeparator {
        didSet {
            for separator in separators.values {
                separator.backgroundColor = separatorColor
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

    public var items: [FloatingAccessoryButtonItem] = []

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
        guard
            !buttonViews.keys.contains(item),
            !items.contains(item) else {
            return
        }
        items.append(item)
        let separatorItem = FloatingAccessorySeparatorItem()
        separators[item] = separatorItem
        separatorItem.backgroundColor = separatorColor
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
     Adds the elements of a sequence or collection to the view's items.

     This methods adds every items from the given sequence.

     - parameter newItems: Sequence of items to be added.

     # Notes: #
     1. Parameters must be **FloatingAccessoryButtonItem** type

     # Example #
     ```
     var items = [item1, item2, item3]
     accessoryView.addItems(contentsOf: items)
     ```
     */
    public func addItems<S>(contentsOf newItems: S) where S : Sequence, S.Element == FloatingAccessoryButtonItem {
        for item in newItems {
            addItem(item)
        }
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
        if let correspondingIndex = items.firstIndex(of: item) {
            items.remove(at: correspondingIndex)
        }
        removeFirstItemSeparatorIfNeeded()
    }

    /**
     Removes all items from the view.

     Calling this method removes every item in the view. The view is thus not displayed anymore.

     # Example #
     ```
     accessoryView.removeAllItems()
     ```
     */
    public func removeAllItems() {
        items.removeAll()
        buttonViews.removeAll()
        separators.removeAll()
        stackView.ad_removeAllArrangedSubviews()
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

    private func removeFirstItemSeparatorIfNeeded() {
        if let firstStackViewSubview = stackView.subviews.first as? FloatingAccessorySeparatorItem,
           separators.values.contains(firstStackViewSubview) {
            firstStackViewSubview.removeFromSuperview()
        }
    }

}
