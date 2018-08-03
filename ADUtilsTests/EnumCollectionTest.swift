//
//  EnumCollectionTest.swift
//  ADUtils
//
//  Created by Benjamin Lavialle on 23/01/2017.
//
//

import Foundation
import Quick
import Nimble
import ADUtils

private enum IntEnum: Int, EnumCollection {
    case one, two, three
}

private enum StringEnum: String, EnumCollection {
    case oneString, twoString, threeString
}

private enum GenericEnum: EnumCollection {
    case oneGeneric, twoGeneric, threeGeneric
}

class EnumCollectionTest: QuickSpec {

    override func spec() {
        it("should enumerate int enum properly") {
            let allValues = IntEnum.allValues
            expect(allValues).to(equal([IntEnum.one, IntEnum.two, IntEnum.three]))
        }
        it("should enumerate string enum properly") {
            let allValues = StringEnum.allValues
            expect(allValues).to(equal([StringEnum.oneString, StringEnum.twoString, StringEnum.threeString]))
        }
        it("should enumerate generic enum properly") {
            let allValues = GenericEnum.allValues
            expect(allValues).to(equal([GenericEnum.oneGeneric, GenericEnum.twoGeneric, GenericEnum.threeGeneric]))
        }
    }
}
