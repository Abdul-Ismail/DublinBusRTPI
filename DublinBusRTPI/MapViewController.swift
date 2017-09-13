//
//  MapViewController.swift
//  DublinBusRTPI
//
//  Created by Abdulaziz Ismail on 12/09/2017.
//  Copyright © 2017 Abdulaziz Ismail. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBAction func myLocationButton(_ sender: Any) {
        
        reloadAnnotations()
        let location = CLLocationCoordinate2DMake(53.279135, -6.137951944)
        mapView.setRegion(MKCoordinateRegionMakeWithDistance(location, 100, 100), animated: true)
    }
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let location = CLLocationCoordinate2DMake(53.279135, -6.137951944)
        mapView.setRegion(MKCoordinateRegionMakeWithDistance(location, 100, 100), animated: true)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        reloadAnnotations()
    }
    
    func reloadAnnotations() {
        mapView.removeAnnotations(mapView.annotations)
        for index in 0...busData.count-1 {
            var latitudeDouble = Double(busData[index].latitude!)
            var longitudeDouble = Double(busData[index].longitude!)
            var location = CLLocationCoordinate2DMake(latitudeDouble!, longitudeDouble!)
            if mapView.contains(coordinate: location) {
                let pin = PinAnnotation(title: busData[index].stopId!, subtitle: "test test", coordinate: location)
                mapView.addAnnotation(pin)
            }
        }
    }

}

extension MKMapView {
    
    func contains(coordinate: CLLocationCoordinate2D) -> Bool {
        return MKMapRectContainsPoint(self.visibleMapRect, MKMapPointForCoordinate(coordinate))
    }
    
}
