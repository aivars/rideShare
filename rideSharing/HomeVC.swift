//
//  ViewController.swift
//  rideSharing
//
//  Created by Aivars Meijers on 21.07.17.
//  Copyright © 2017. g. Aivars Meijers. All rights reserved.
//

import UIKit
import MapKit
import  CoreLocation


class HomeVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var actionButton: RoundedShadowButton!
    
    var delegate: CenterVCDelegate?
    var manager: CLLocationManager?
    var regionRadius: CLLocationDistance = 1000
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        manager = CLLocationManager()
        manager?.delegate = self
        manager?.desiredAccuracy = kCLLocationAccuracyBest
        
        mapView.delegate = self as? MKMapViewDelegate
        checkLocationStatus()
        centerMapOnUserLocation()
    }
    
    //Start Location and request access if needed
    func checkLocationStatus(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            
            manager?.startUpdatingLocation()
        } else {
            manager?.requestWhenInUseAuthorization()
        }
    
    }
    
    func centerMapOnUserLocation (){
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func actionButtonPressed(_ sender: Any) {
        actionButton.animateButton(shouldLoad: true, withMessage: nil)
    }

    @IBAction func menuButtonPressed(_ sender: Any) {
        delegate?.toggleLeftPanel()
    }
    @IBAction func onCenterMapButton(_ sender: UIButton) {
        centerMapOnUserLocation()
    }
}

extension HomeVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationStatus()
        if status == .authorizedWhenInUse {
            checkLocationStatus()
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .follow
        }
        
    }
}

