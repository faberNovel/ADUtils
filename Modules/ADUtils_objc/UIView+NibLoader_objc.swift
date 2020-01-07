//
//  UIView+NibLoader.swift
//  Pods
//
//  Created by Benjamin Lavialle on 27/12/2016.
//
//

import Foundation
import UIKit

extension UIView {

    @objc public class func adobjc_fromNib() -> Self {
        return ad_fromNib()
    }

    @objc public class func adobjc_fromNib(_ nibNameOrNil: String?) -> Self {
        return ad_fromNib(nibNameOrNil)
    }

    @objc public class func adobjc_fromNib(_ nibNameOrNil: String?, owner: AnyObject?) -> Self {
        return ad_fromNib(nibNameOrNil, owner: owner)
    }

    @objc public class func adobjc_fromNib(_ nibNameOrNil: String?,
                                           owner: AnyObject?,
                                           bundle: Bundle) -> Self {
        return ad_fromNib(nibNameOrNil, owner: owner, bundle: bundle)
    }

}
