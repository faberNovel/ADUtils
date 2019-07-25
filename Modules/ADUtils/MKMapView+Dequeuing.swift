//
//  MKMapView+Dequeuing.swift
//  ADUtils
//
//  Created by Thibault Farnier on 13/06/2019.
//

import Foundation
import MapKit

public extension MKMapView {
    func dequeueAnnotationView<U: MKAnnotationView>(annotationView: U.Type = U.self, annotation: MKAnnotation) -> U {
        if let reusableView = dequeueReusableAnnotationView(withIdentifier: U.identifier()) as? U {
            return reusableView
        } else {
           return U(
                annotation: annotation,
                reuseIdentifier: U.identifier()
            )
        }
    }
}
