//
//  callViewController.swift
//  HelpMeSecurity
//
//  Created by Александр on 28.04.17.
//  Copyright © 2017 Александр. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import FirebaseDatabase

class callViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    var userPinView : MKAnnotationView!
    
    @IBAction func callButton(_ sender: Any) {
    }
    
    @IBAction func theDiz(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var slideButtonOne: UIButton!
    
    @IBAction func slideButtonView(_ sender: Any) {
      slideButtonOne.isHidden = true
      self.performSegue(withIdentifier: "showLK", sender: nil)
      AlertStandart().show("Подтверждение", text: "Подтвердите вызов", view: self)
    }
    
    @IBAction func zoomPlus(_ sender: Any) {
        let spanZoom = MKCoordinateSpan(latitudeDelta: mapView.region.span.latitudeDelta/2, longitudeDelta: mapView.region.span.longitudeDelta/2)
        let region = MKCoordinateRegion(center: mapView.region.center, span: spanZoom)
        mapView.setRegion(region, animated: true)
    }
    @IBAction func zoomMinus(_ sender: Any) {
        let spanZoom = MKCoordinateSpan(latitudeDelta: mapView.region.span.latitudeDelta/2, longitudeDelta: mapView.region.span.longitudeDelta*2)
        let region = MKCoordinateRegion(center: mapView.region.center, span: spanZoom)
        mapView.setRegion(region, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        geoPostion()
    }
    
    
    
    
    func geoPostion(){
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
    }
    
    func zoom(){
        let spanZoom = MKCoordinateSpan(latitudeDelta: mapView.region.span.latitudeDelta/2, longitudeDelta: mapView.region.span.longitudeDelta*2)
        let region = MKCoordinateRegion(center: mapView.region.center, span: spanZoom)
        mapView.setRegion(region, animated: true)
    }
    
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            let pin = mapView.view(for: annotation) ?? MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
            pin.image = UIImage(named: "navigation")
            userPinView = pin
            return pin
        } else{
            
        }
        return nil
    }
    

    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        let result : Double = (newHeading.magneticHeading * .pi/180)
        let theTransform  = CGAffineTransform(rotationAngle: CGFloat(result))
        userPinView.transform = theTransform
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: center, span: span)
        
        let user_lat = String(format: "%f", (manager.location?.coordinate.latitude)!)
        let user_lap = String(format: "%f", (manager.location?.coordinate.longitude)!)
        
        let lat_d = Double(user_lat)
        let lap_d = Double(user_lap)
        
        var ref : FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            let array = snapshot.value as? NSArray
            let itemLong = ref.child("users/\(((array?.count)!-1))/lat")
            let itemLap = ref.child("users/\((array?.count)!-1)/lap")
            
            
            itemLong.observe(.value, with: { snapshot in
                var result = Double((snapshot.value!) as! String)
                itemLap.observe(.value, with: { snapshot in
                    var resultTwo = Double((snapshot.value!) as! String)
                    self.put(lat: lat_d, long: lap_d, laptwo: resultTwo, longTwo: result)
                    
                })
            })
        })
        locationManager.stopUpdatingLocation()
    }
    
    func put(lat: CLLocationDegrees?, long:  CLLocationDegrees?, laptwo: CLLocationDegrees?, longTwo: CLLocationDegrees? ){
        
        let sourceLocation = CLLocationCoordinate2D(latitude: lat!, longitude: long!)
        let destinationLocation = CLLocationCoordinate2D(latitude: laptwo!, longitude: longTwo!)
        
        // 3.
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        
        // 4.
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.title = "вызов"
        
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }
        
        // 6.
        self.mapView.showAnnotations([destinationAnnotation], animated: true )
        
        // 7.
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        // Calculate the direction
        let directions = MKDirections(request: directionRequest)
        
        // 8.
        directions.calculate {
            (response, error) -> Void in
            
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                
                return
            }
            
            let route = response.routes[0]
            self.mapView.add((route.polyline), level: MKOverlayLevel.aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
            
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 4.0
        
        return renderer
    }
}



