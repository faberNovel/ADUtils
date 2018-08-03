//
//  ArrayFilterTests.swift
//  ADUtilsTests
//
//  Created by Pierre Felgines on 31/05/2018.
//

import Foundation
import Quick
import Nimble
import ADUtils

private struct Vendor {
    let name: String
    let address: String
}

class ArrayFilterTests: QuickSpec {

    override func spec() {

        it("should filter the array") {
            let vendors = [
                Vendor(name: "John", address: "Street 100"),
                Vendor(name: "Brian", address: "John Boulevard 23"),
                Vendor(name: "Jordan", address: "Avenue 67"),
            ]

            let keyPaths = [
                \Vendor.name,
                \Vendor.address
            ]

            var results = vendors.ad_filter(query: "an 7", for: keyPaths)
            expect(results.count).to(equal(1))
            let result = results[0]
            expect(result.name).to(equal("Jordan"))

            results = vendors.ad_filter(query: "john", for: keyPaths)
            expect(results.count).to(equal(2))
            expect(results.map { $0.name }).to(equal(["John", "Brian"]))
        }
    }
}
