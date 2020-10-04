//
//  MapViewController.swift
//  SportActivity
//
//  Created by Nail Safin on 28.09.2020.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapViewController: UIViewController {
    
    //MARK: Properties
    var coordinate = CLLocationCoordinate2D(latitude: 55.753215, longitude: 37.622504)
    var marker: GMSMarker?
    var tappedCoordinate: CLLocationCoordinate2D?
    var locationManager: CLLocationManager?
    var geocoder = CLGeocoder()
    var status: RouteStatus = .free
    var route: GMSPolyline?
    var routePath: GMSMutablePath?
    var realmRoute = LocationRealmModel()
    var database = LocationRepository()
    
    @IBOutlet weak var mapView: GMSMapView!


    
    // MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()

        configurateLocationManager()
        configurateMap()
        configurateRouteDrawer()
     
        
    }
    

    //MARK: - Handlers
    
    func configurateMap() {
        
        let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: 15)
        mapView.camera = camera
        
        mapView.delegate = self
    }
    
    func configurateLocationManager() {
       
        
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.allowsBackgroundLocationUpdates = true
        locationManager?.pausesLocationUpdatesAutomatically = false
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startMonitoringSignificantLocationChanges()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.startUpdatingLocation()
        
    }
    
    func configurateRouteDrawer() {
        route?.map = nil
        route = GMSPolyline()
        routePath = GMSMutablePath()
        route?.map = mapView
        route?.strokeWidth = 4
        route?.strokeColor = .systemBlue
    }
    
    func setMarker(position: CLLocationCoordinate2D) {
        let marker = GMSMarker(position: position)
        marker.map = mapView
        self.marker = marker
    }
    
    func removeMarker() {
        marker?.map = nil
        marker = nil
    }
    
    func getLastRoute() {
        do{
            self.realmRoute = try database.getLastRoute(route: realmRoute)
        } catch{
            print(error)
        }
        
    }

    @IBAction func backButton(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "goToStart", sender: self)
    }
    
 
    @IBAction func lastRouteButton(_ sender: Any) {
        status = .show
        
    }
    
    @IBAction func startRecordingRoute(_ sender: Any) {
        status = .save
        
    }
    
    
    @IBAction func stopRecordingRoute(_ sender: Any) {
        status = .stop
    }
    
    @IBAction func homeButton(_ sender: UIBarButtonItem) {
        removeMarker()
        setMarker(position: tappedCoordinate ?? coordinate)
        
    }
    
    

}
// MARK: - Extensions

extension MapViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        self.tappedCoordinate = coordinate
    }
    
}


extension MapViewController: CLLocationManagerDelegate {
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        switch status {
        case .free:
            routePath?.add(location.coordinate)
            route?.path = routePath
            mapView.animate(toLocation: location.coordinate)
            self.coordinate = location.coordinate
        case .save:
            routePath?.add(location.coordinate)
            route?.path = routePath
            self.coordinate = location.coordinate
            mapView.animate(toLocation: location.coordinate)
            database.saveRoute(route: realmRoute)
            route?.strokeColor = .systemRed
            database.addRoutePoint(route: realmRoute, location: location.coordinate)
        case .stop:
            routePath?.add(location.coordinate)
            route?.path = routePath
            self.coordinate = location.coordinate
            mapView.animate(toLocation: location.coordinate)
            database.saveRoute(route: realmRoute)
            route?.strokeColor = .systemBlue
        case .show:
            getLastRoute()
            mapView.animate(toLocation: realmRoute.coordinate.first?.coordinate ?? location.coordinate)
            routePath?.add(realmRoute.coordinate.first?.coordinate ?? location.coordinate)
            route?.path = routePath
            route?.strokeColor = .cyan
            

        }
      
        
        
       
        
        

    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
// MARK: - Navigation
