//
//  String+Image.swift
//  Pods
//
//  Created by Benjamin Lavialle on 21/11/16.
//
//

import Foundation

extension String {

    public func image() -> UIImage? {
        return UIImage(named: self)
    }
}
