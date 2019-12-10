//
//  UIView+NibLoader.swift
//  CleanCodeDemo
//
//  Created by Pierre Felgines on 17/05/16.
//
//

import Foundation
import UIKit

/// NibLoadable is a semantic protocol defining an object instanciatable from a nib
public protocol NibLoadable {}

extension UIView: NibLoadable {}

// http://stackoverflow.com/a/26326006/900937
extension NibLoadable {

    /**
     Instanciate a Self object from a nib
     - parameter nibNameOrNil: A custom nib name, if nil Self name is used as nibs are generally demangled, default is nil
     - parameter owner: The nib owner, default is nil
     - parameter bundle: The nib bundle, default is main bundle
     - note: Crashes if unable to instanciate the objet, meaning if there is no matching nib
     */
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
