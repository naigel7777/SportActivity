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
    let coordinate = CLLocationCoordinate2D(latitude: 55.753215, longitude: 37.622504)
    var marker: GMSMarker?
    var tappedCoordinate: CLLocationCoordinate2D?
    var locationManager: CLLocationManager?
    var geocoder = CLGeocoder()
    
    @IBOutlet weak var mapView: GMSMapView!


    
    // MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()

        configurateLocationManager()
        configurateMap()
     
        
    }
    

    //MARK: - Handlers
    
    func configurateMap() {
        
        let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: 15)
        mapView.camera = camera
        
        mapView.delegate = self
    }
    
    func configurateLocationManager() {
        
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.delegate = self
        locationManager?.startUpdatingLocation()
        
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
    


    @IBAction func backButton(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "goToStart", sender: self)
    }
    
 
    
    @IBAction func homeButton(_ sender: UIBarButtonItem) {
        mapView.animate(toLocation: coordinate)
        
    }
    
    @IBAction func setPositionButton(_ sender: UIButton) {
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
        if let location = locations.first {
            mapView.animate(toLocation: location.coordinate)
            geocoder.reverseGeocodeLocation(location) { (place, error) in
                if let  error = error {
                    print(error)
                }
                else {
                    print(place?.first?.location)
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
// MARK: - Navigation
