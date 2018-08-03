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
    public class func ad_fromNib<T : UIView>(_ nibNameOrNil: String? = nil,
                                 owner: AnyObject? = nil,
                                 bundle: Bundle = Bundle.main) -> T {
        let v: T? = ad_fromNib(nibNameOrNil, owner: owner, bundle: bundle)
        return v!
    }

    public class func ad_fromNib<T : UIView>(_ nibNameOrNil: String? = nil,
                                 owner: AnyObject? = nil,
                                 bundle: Bundle = Bundle.main) -> T? {
        var view: T?
        let name: String
        if let nibName = nibNameOrNil {
            name = nibName
        } else {
            // Most nibs are demangled by practice, if not, just declare string explicitly
            name = "\(T.self)".components(separatedBy: ".").last!
        }
        guard let nibViews = bundle.loadNibNamed(name, owner: owner, options: nil) else { return nil }
        for v in nibViews {
            if let tog = v as? T {
                view = tog
            }
        }
        return view
    }
}
