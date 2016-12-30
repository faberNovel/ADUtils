//
//  UIView+NibLoader.swift
//  Pods
//
//  Created by Benjamin Lavialle on 27/12/2016.
//
//

import Foundation

extension UIView {

    @objc public class func adobjc_fromNib() -> Self? {
        return adobjc_fromNib(nil)
    }

    @objc public class func adobjc_fromNib(nibNameOrNil: String?) -> Self? {
        return ad_fromNib(nibNameOrNil)
    }
}
