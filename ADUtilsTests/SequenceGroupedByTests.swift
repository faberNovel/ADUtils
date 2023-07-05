//
//  SequenceGroupedByTests.swift
//  ADUtilsTests
//
//  Created by Pierre Felgines on 24/09/2018.
//

import Foundation
import Quick
import Nimble
import ADUtils

private struct Person {
    let name: String
    let age: Int
}

class SequenceGroupedByTests: QuickSpec {

    override class func spec() {

        it("should group the sequence") {
            let persons = [
                Person(name: "John", age: 10),
                Person(name: "Brian", age: 20),
                Person(name: "Peter", age: 30),
                Person(name: "Bob", age: 10),
            ]
            let results = persons.ad_groupedBy { $0.age }
            let nameResults = results.mapValues { persons in
                persons.map { $0.name }
            }
            let expectedResults: [Int: [String]] = [
                10: ["John", "Bob"],
                20: ["Brian"],
                30: ["Peter"]
            ]
            expect(nameResults).to(equal(expectedResults))
        }
    }
}
