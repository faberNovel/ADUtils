//
//  UIView+NibLoader.swift
//  CleanCodeDemo
//
//  Created by Pierre Felgines on 17/05/16.
//
//

import Foundation

// http://stackoverflow.com/a/26326006/900937
extension UIView {
    class func ad_fromNib<T : UIView>(nibNameOrNil: String? = nil) -> T {
        let v: T? = ad_fromNib(nibNameOrNil)
        return v!
    }

    class func ad_fromNib<T : UIView>(nibNameOrNil: String? = nil) -> T? {
        var view: T?
        let name: String
        if let nibName = nibNameOrNil {
            name = nibName
        } else {
            // Most nibs are demangled by practice, if not, just declare string explicitly
            name = "\(T.self)".componentsSeparatedByString(".").last!
        }
        guard let nibViews = NSBundle.mainBundle().loadNibNamed(name, owner: nil, options: nil) else { return nil }
        for v in nibViews {
            if let tog = v as? T {
                view = tog
            }
        }
        return view
    }
}
