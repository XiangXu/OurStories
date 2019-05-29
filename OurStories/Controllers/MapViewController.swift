//
//  MapViewController.swift
//  Carandus
//
//  Created by Xiang Xu on 21/05/2019.
//  Copyright © 2018 Xiang Xu. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate
{    
    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.mapType = .hybrid
        mapView.delegate = self
        mapView.showsCompass = false
        mapView.showsScale = false
        return mapView
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        navigationItem.title = "我们的足迹"
        
        view.backgroundColor = .white
        
        view.addSubview(mapView)
        
        mapView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor,
                       paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0,
                       width: 0, height: 0)
    }
    
}
