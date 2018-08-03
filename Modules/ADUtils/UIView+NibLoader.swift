//
//  UIView+NibLoader.swift
//  CleanCodeDemo
//
//  Created by Pierre Felgines on 17/05/16.
//
//

import Foundation

public protocol NibLoadable {}

extension UIView: NibLoadable {}

// http://stackoverflow.com/a/26326006/900937
extension NibLoadable where Self: NibLoadable {

    public static func ad_fromNib(_ nibNameOrNil: String? = nil,
                                  owner: AnyObject? = nil,
                                  bundle: Bundle = Bundle.main) -> Self {
        let v: Self? = ad_fromNib(nibNameOrNil, owner: owner, bundle: bundle)
        return v!
    }

    // MARK: - Private

    private static func ad_fromNib(_ nibNameOrNil: String? = nil,
                                  owner: AnyObject? = nil,
                                  bundle: Bundle = Bundle.main) -> Self? {
        var view: Self?
        let name: String
        if let nibName = nibNameOrNil {
            name = nibName
        } else {
            // Most nibs are demangled by practice, if not, just declare string explicitly
            name = "\(Self.self)".components(separatedBy: ".").last!
        }
        guard let nibViews = bundle.loadNibNamed(name, owner: owner, options: nil) else { return nil }
        for v in nibViews {
            if let tog = v as? Self {
                view = tog
            }
        }
        return view
    }
}
