//
//  ViewController.swift
//  GoogleMapsDemo
//
//  Created by Apple on 22/12/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var mapView : GMSMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        mapView = GMSMapView()
        
        let targetChennai = CLLocationCoordinate2D(latitude: 12.994007, longitude: 80.170953)
        mapView!.camera = GMSCameraPosition.cameraWithTarget(targetChennai, zoom: 6)
        
        let targetMumbai = CLLocationCoordinate2D(latitude: 19.090066, longitude: 72.865636)
        mapView!.camera = GMSCameraPosition.cameraWithTarget(targetMumbai, zoom: 6)
        
        let targetUserLocation = CLLocationCoordinate2D(latitude: 13.026032, longitude: 77.626776)
        mapView!.camera = GMSCameraPosition.cameraWithTarget(targetUserLocation, zoom: 6)
        
        view = mapView
        
        // Creates a marker in the  Chennai AirPort of the map.
        let markerChennai = GMSMarker()
        markerChennai.position = CLLocationCoordinate2D(latitude: 12.994007, longitude: 80.170953)
        markerChennai.title = "Chennai AirPort"
        markerChennai.snippet = "Tamil Nadu"
        // marker color = blue
        markerChennai.icon = GMSMarker.markerImageWithColor(UIColor.blueColor())
        markerChennai.map = mapView
        
        // Creates a marker in the  Mumbai Airport of the map.
        let markerMumbai = GMSMarker()
        markerMumbai.position = CLLocationCoordinate2D(latitude: 19.090066, longitude: 72.865636)
        markerMumbai.title = "Mumbai Airport"
        markerMumbai.snippet = "Maharashtra"
        // marker color = red
        markerMumbai.icon = GMSMarker.markerImageWithColor(UIColor.redColor())
        markerMumbai.map = mapView
        
        // Creates a marker in the  currentLocation of the map.
        let markerMyLocation = GMSMarker()
        markerMyLocation.position = CLLocationCoordinate2D(latitude: 13.026032, longitude: 77.626776)
        markerMyLocation.title = "Current Location" 
        // marker color = green
        markerMyLocation.icon = GMSMarker.markerImageWithColor(UIColor.greenColor())
        markerMyLocation.map = mapView
        
        //polyline currentLocation To Mumbai
        let pathMumbai = GMSMutablePath()
        pathMumbai.addLatitude(19.090066, longitude: 72.865636)
        pathMumbai.addLatitude(13.026032, longitude: 77.626776)
        let polylineToMumbai = GMSPolyline(path: pathMumbai)
        polylineToMumbai.strokeWidth = 5.0
        polylineToMumbai.geodesic = true
        polylineToMumbai.strokeColor = UIColor.brownColor()
        polylineToMumbai.map = mapView
        
        //polyline currentLocation To Chennai
        let pathChennai = GMSMutablePath()
        pathChennai.addLatitude(12.994007, longitude: 80.170953)
        pathChennai.addLatitude(13.026032, longitude: 77.626776)
        let polylineToChennai = GMSPolyline(path: pathChennai)
        polylineToChennai.strokeWidth = 5.0
        polylineToChennai.geodesic = true
        polylineToChennai.strokeColor = UIColor.cyanColor()
        polylineToChennai.map = mapView
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension ViewController {
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.last
        let targetUserLocation = CLLocationCoordinate2D(latitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude)
        let camera = GMSCameraPosition.cameraWithTarget(targetUserLocation, zoom: 13.0)
        mapView = GMSMapView.mapWithFrame(CGRect.zero, camera: camera)
        //mapView.isMyLocationEnabled = true
        self.view = mapView
        
        locationManager.stopUpdatingLocation()
        
    }
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
            mapView!.myLocationEnabled = true
            mapView!.settings.myLocationButton = true
        }
        
    }
}
