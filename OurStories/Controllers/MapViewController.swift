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
    let stories = StoryStore.shared.stories
    
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
        mapView.register(PhotoAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.register(PhotoAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
        for (index, story) in stories.enumerated() {
            mapView.addAnnotation(VisitPlace(title: story.location, subtitle: story.date?.displayText, coordinate: story.coordinate,
                                             imageName: story.imageName, order: index))
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
    
    func mapView(_ mapView: MKMapView, clusterAnnotationForMemberAnnotations memberAnnotations: [MKAnnotation]) -> MKClusterAnnotation
    {
        let cluster = MKClusterAnnotation(memberAnnotations: memberAnnotations)
        let places = memberAnnotations.compactMap { $0 as? VisitPlace }
        cluster.title = places.min { $0.order < $1.order }?.title
        cluster.subtitle = "共\(places.count)个故事"
        return cluster
    }
    
    // Tapping a group zooms in until its stories come apart.
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    {
        guard let cluster = view.annotation as? MKClusterAnnotation else { return }
        
        var mapRect = MKMapRect.null
        for member in cluster.memberAnnotations {
            mapRect = mapRect.union(MKMapRect(origin: MKMapPoint(member.coordinate), size: MKMapSize(width: 0, height: 0)))
        }
        // Stories at the very same spot cannot be pulled apart, so their callout stays instead.
        guard max(mapRect.width, mapRect.height) > 2_000 else { return }
        
        mapView.deselectAnnotation(cluster, animated: false)
        mapView.setVisibleMapRect(mapRect, edgePadding: UIEdgeInsets(top: 120, left: 70, bottom: 100, right: 70), animated: true)
    }
}
