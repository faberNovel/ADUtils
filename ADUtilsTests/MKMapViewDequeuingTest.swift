//
//  MKMapViewDequeuingTest.swift
//  ADUtilsTests
//
//  Created by Thibault Farnier on 13/06/2019.
//

import Foundation
import Quick
import Nimble
import ADUtils
import UIKit
import MapKit

class MapViewAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: 0, longitude: 0)
    }
}

class MapViewAnnotationView: MKAnnotationView {

}

class MKMapViewDequeuingTest: QuickSpec {
    override func spec() {
        describe("Dequeuing") {
            var mapView = MKMapView()

            beforeEach {
                mapView = MKMapView()
            }

            it("Should dequeue MapViewAnnotationView") {
                let annotation = MapViewAnnotation()
                mapView.addAnnotation(annotation)
                let annotationView: MapViewAnnotationView = mapView.dequeueAnnotationView(
                    annotation: annotation
                )
                expect(annotationView).toNot(beNil())
            }
        }
    }
}
