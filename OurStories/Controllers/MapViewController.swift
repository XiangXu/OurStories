//
//  MapViewController.swift
//  Carandus
//
//  Created by Xiang Xu on 21/05/2019.
//  Copyright © 2018 Xiang Xu. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate
{
    let stories = Story.storyGenerate()
    
    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.delegate = self
        mapView.showsCompass = false
        mapView.showsScale = false
        return mapView
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        navigationItem.title = "我们的足迹"
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(mapView)
        
        mapView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor,
                       paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0,
                       width: 0, height: 0)
        setupAnnotation()
    }
    
    private func setupAnnotation()
    {
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        for story in stories {
            mapView.addAnnotation(VisitPlace(title: story.location, coordinate: story.coordinate))
        }
    }
    
    private var hasFittedAnnotations = false
    
    // The map needs its final size before it can work out a region that fits the pins.
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        guard !hasFittedAnnotations, mapView.bounds.width > 0, !stories.isEmpty else { return }
        hasFittedAnnotations = true
        
        // A phone screen cannot show the whole world, so open on the area around the typical
        // story (the median coordinate) and leave the far-away pins to be found by panning.
        let latitudes = stories.map { $0.coordinate.latitude }.sorted()
        let longitudes = stories.map { $0.coordinate.longitude }.sorted()
        let median = CLLocation(latitude: latitudes[latitudes.count / 2], longitude: longitudes[longitudes.count / 2])
        
        var mapRect = MKMapRect.null
        for story in stories {
            let location = CLLocation(latitude: story.coordinate.latitude, longitude: story.coordinate.longitude)
            if location.distance(from: median) < 2_500_000 {
                mapRect = mapRect.union(MKMapRect(origin: MKMapPoint(story.coordinate), size: MKMapSize(width: 0, height: 0)))
            }
        }
        mapView.setVisibleMapRect(mapRect, edgePadding: UIEdgeInsets(top: 80, left: 50, bottom: 60, right: 50), animated: false)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        guard annotation is VisitPlace else { return nil }
        
        let view = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier, for: annotation)
        if let marker = view as? MKMarkerAnnotationView {
            marker.markerTintColor = .rose
            marker.glyphImage = UIImage(systemName: "heart.fill")
        }
        return view
    }
}
