//
//  LocationRepository.swift
//  SportActivity
//
//  Created by Nail Safin on 01.10.2020.
//

import Foundation
import RealmSwift
import CoreLocation

protocol LocationSource {
    func saveRoute(route: LocationRealmModel)
    func addRoutePoint(route: LocationRealmModel, location: CLLocationCoordinate2D)
    func getLastRoute(route: LocationRealmModel) throws -> LocationRealmModel
    
}

class LocationRepository: LocationSource {
    func saveRoute(route: LocationRealmModel) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(route, update: .modified)
        }
        
    }
    
    func addRoutePoint(route: LocationRealmModel, location: CLLocationCoordinate2D) {
        let realm = try! Realm()
        let realmCoordinates = CoordinateList()
        realmCoordinates.latitude = location.latitude
        realmCoordinates.longitude = location.longitude
        
        try! realm.write {
            route.coordinate.append(realmCoordinates)
        }
    }
    
    func getLastRoute(route: LocationRealmModel) throws -> LocationRealmModel {
        do{
            let realm = try Realm()
            return realm.objects(LocationRealmModel.self).first ?? route
        } catch {
            throw error
        }
    }
}

