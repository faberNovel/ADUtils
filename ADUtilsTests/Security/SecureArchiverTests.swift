//
//  ArrayFilterTests.swift
//  ADUtilsTests
//
//  Created by Thomas Esterlin on 06/07/2021.
//

import Foundation
import Quick
import Nimble
import ADUtils

private struct Car: Codable {
    let color: String
    let brand: String
    let year: Int
}

extension Car: Equatable {
    static func ==(lhs: Car, rhs: Car) -> Bool {
        return lhs.color == rhs.color
            && lhs.brand == rhs.brand
            && lhs.year == lhs.year
    }
}

private class StorageArchiverImplementation: StorageArchiver {

    private var storage: [String: Data] = [:]

    func get(forKey key: String) -> Data? {
        return storage[key]
    }

    func set(_ data: Data, forKey key: String) {
        storage[key] = data
    }

    func deleteValue(forKey key: String) {
        storage[key] = nil
    }
    
}

private class KeychainArchiverImplementation: KeychainArchiver {

    private var storage: [String: String] = [:]

    func get(forKey: String) -> String? {
        return storage[forKey]
    }

    func set(value: String?, forKey: String) {
        storage[forKey] = value
    }

    func cleanStorage() {
        storage = [:]
    }

}

class SecureArchiverTests: QuickSpec {

    override func spec() {

        var defaults: UserDefaults!
        var storageArchiver: StorageArchiverImplementation!
        var keychainArchiver: KeychainArchiverImplementation!

        beforeEach {
            defaults = UserDefaults.standard
            storageArchiver = StorageArchiverImplementation()
            keychainArchiver = KeychainArchiverImplementation()
        }

        describe("Write and Read tests") {
            it("should write and read one codable") {
                let myCar = Car(color: "Grey", brand: "Ford", year: 1967)
                do {
                    if #available(iOS 13.0, *) {
                        // Given
                        let secureArchiver = try SecureArchiver(
                            defaults: defaults,
                            keychainArchiver: keychainArchiver,
                            storageArchiver: storageArchiver,
                            appKey: ""
                        )

                        // When
                        try secureArchiver.set(myCar, forKey: "car")
                        let readCar: Car? = try secureArchiver.value(forKey: "car")

                        //Then
                        expect(readCar).toNot(beNil())
                        if let readCar = readCar {
                            expect(readCar).to(equal(myCar))
                        }
                    }
                } catch {
                    fail()
                }
            }

            it("should write and read several codables") {
                let myFirstCar = Car(color: "Grey", brand: "Ford", year: 1967)
                let mySecondCar = Car(color: "Blue", brand: "Porsche", year: 1999)
                let myCars = [myFirstCar, mySecondCar]
                do {
                    if #available(iOS 13.0, *) {
                        // Given
                        let secureArchiver = try SecureArchiver(
                            defaults: defaults,
                            keychainArchiver: keychainArchiver,
                            storageArchiver: storageArchiver,
                            appKey: ""
                        )

                        // When
                        try secureArchiver.set(myCars, forKey: "cars")
                        let readCars: [Car] = try secureArchiver.value(forKey: "cars") ?? []

                        //Then
                        expect(readCars.count).to(equal(2))
                        expect(readCars).to(equal(myCars))
                    }
                } catch {
                    fail()
                }
            }

            it("should delete codables") {
                let myCar = Car(color: "Grey", brand: "Ford", year: 1967)
                do {
                    if #available(iOS 13.0, *) {
                        // Given
                        let secureArchiver = try SecureArchiver(
                            defaults: defaults,
                            keychainArchiver: keychainArchiver,
                            storageArchiver: storageArchiver,
                            appKey: ""
                        )

                        // When
                        try secureArchiver.set(myCar, forKey: "car")
                        secureArchiver.deleteValue(forKey: "car")
                        let readCar: Car? = try secureArchiver.value(forKey: "car")

                        // Then
                        expect(readCar).to(beNil())
                    }
                } catch {
                    fail()
                }
            }
        }

        describe("passphrase tests") {
            it("passphrase should be set when application is installed") {
                do {
                    if #available(iOS 13.0, *) {
                        // Given
                        let secureArchiver = try SecureArchiver(
                            defaults: defaults,
                            keychainArchiver: keychainArchiver,
                            storageArchiver: storageArchiver,
                            appKey: "secureArchiverTests"
                        )

                        // When
                        try secureArchiver.set("Hello", forKey: "myWord")
                        let storedPassphrase = keychainArchiver.get(forKey: "cryptoKeyPassphrase_secureArchiverTests")

                        //Then
                        expect(storedPassphrase).toNot(beNil())
                    }
                } catch {
                    fail()
                }
            }

            it("passphrase should be different when application is re-installed") {
                do {
                    if #available(iOS 13.0, *) {
                        // Given
                        let secureArchiver = try SecureArchiver(
                            defaults: defaults,
                            keychainArchiver: keychainArchiver,
                            storageArchiver: storageArchiver,
                            appKey: "secureArchiverTests"
                        )

                        // When
                        try secureArchiver.set("Hello", forKey: "myWord")
                        let firstStoredPassphrase = keychainArchiver.get(forKey: "cryptoKeyPassphrase_secureArchiverTests")
                        keychainArchiver.cleanStorage()
                        try secureArchiver.set("Hello", forKey: "myWord")
                        let secondStoredPassphrase = keychainArchiver.get(forKey: "cryptoKeyPassphrase_secureArchiverTests")

                        //Then
                        expect(firstStoredPassphrase).toNot(equal(secondStoredPassphrase))
                    }
                } catch {
                    fail()
                }
            }

            it("UserDefaults should know if the app was installed") {
                do {
                    if #available(iOS 13.0, *) {
                        // Given
                        let secureArchiver = try SecureArchiver(
                            defaults: defaults,
                            keychainArchiver: keychainArchiver,
                            storageArchiver: storageArchiver,
                            appKey: "secureArchiverTests"
                        )

                        // When
                        try secureArchiver.set("Hello", forKey: "myWord")
                        let storedInfo = UserDefaults.standard.bool(forKey: "appIsInstalled_secureArchiverTests")

                        //Then
                        expect(storedInfo).to(equal(true))
                    }
                } catch {
                    fail()
                }
            }
        }
    }
}
