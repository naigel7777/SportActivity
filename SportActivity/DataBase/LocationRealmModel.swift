//
//  LocationRealmModel.swift
//  SportActivity
//
//  Created by Nail Safin on 01.10.2020.
//

import Foundation
import RealmSwift
import CoreLocation

class LocationRealmModel: Object {
    @objc dynamic var id: Int = 0
    let coordinate = List<CoordinateList>()
    override class func primaryKey() -> String? {
        return "id"
    }

}

class CoordinateList: Object {
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

