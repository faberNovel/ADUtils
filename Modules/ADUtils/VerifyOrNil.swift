//
//  VerifyOrNil.swift
//  Pods-ADUtilsApp
//
//  Created by Benjamin Lavialle on 07/12/2020.
//

import Foundation

/**
 Apply the provided test on the object, returns the object if positive, nil otherwise

 let myValidObject = .verifyOrNil(myObject) { $0.testableProperty.isValid() }

 - parameter object: the object on which apply the test
 - parameter test: the test to run on the object

 - returns: The object if passing the test, nil otherwise
 */
public func verifyOrNil<Type>(_ object: Type?, over test: (Type) -> Bool) -> Type? {
    (object.flatMap(test) ?? false) ? object : nil
}

public extension Optional {

    /**
     Apply the provided test on the object, returns the object if positive, nil otherwise

     let myValidObject = myObject.verifying { $0.testableProperty.isValid() }

     - parameter test: the test to run on the object

     - returns: The object if passing the test, nil otherwise
     */
    func verifying(_ test: (Wrapped) -> Bool) -> Self {
        verifyOrNil(self, over: test)
    }
}
