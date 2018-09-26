//
//  ProxyDetectorTests.swift
//  ADUtilsTests
//
//  Created by Pierre Felgines on 26/09/2018.
//

import Foundation
import Quick
import Nimble
import ADUtils

class ProxyDetectorTests: QuickSpec {

    override func spec() {

        var proxyDetector: ProxyDetector!

        beforeEach {
            proxyDetector = ProxyDetector()
        }

        it("should be activated on simulator") {
            expect(proxyDetector.isProxyActivated).to(beTrue())
        }

        it("should display alert") {
            // Given
            let viewController = UIViewController()
            UIApplication.shared.keyWindow?.rootViewController = viewController
            UIApplication.shared.keyWindow?.makeKeyAndVisible()
            expect(viewController.presentedViewController).to(beNil())

            // When
            proxyDetector.notifyIfProxyActivated(in: viewController)

            // Then
            expect(viewController.presentedViewController).toNot(beNil())
        }
    }
}
