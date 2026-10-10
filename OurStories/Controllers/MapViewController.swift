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
    
    // The cards of the selected pin: one story, or one page per story when several share a spot.
    // It is narrower than the screen and does not clip, so the next card peeks in at the edge.
    let cardScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.clipsToBounds = false
        scrollView.isHidden = true
        return scrollView
    }()
    
    let cardStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    
    private var isShowingCards = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        navigationItem.title = "我们的足迹"
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(mapView)
        
        mapView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor,
                       paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0,
                       width: 0, height: 0)
        
        view.addSubview(cardScrollView)
        cardScrollView.anchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,
                              paddingTop: 0, paddingLeft: 12, paddingBottom: 12, paddingRight: 12,
                              width: 0, height: 0)
        cardScrollView.addSubview(cardStack)
        cardStack.anchor(top: cardScrollView.contentLayoutGuide.topAnchor, left: cardScrollView.contentLayoutGuide.leftAnchor,
                         bottom: cardScrollView.contentLayoutGuide.bottomAnchor, right: cardScrollView.contentLayoutGuide.rightAnchor,
                         paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0,
                         width: 0, height: 0)
        // The tallest card decides the height, so the cards only scroll sideways.
        cardStack.heightAnchor.constraint(equalTo: cardScrollView.frameLayoutGuide.heightAnchor).isActive = true
        
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
    
    // Tapping a story shows its card; tapping a group zooms in until its stories come apart.
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    {
        if let place = view.annotation as? VisitPlace {
            showCards(for: [place])
            return
        }
        guard let cluster = view.annotation as? MKClusterAnnotation else { return }
        
        var mapRect = MKMapRect.null
        for member in cluster.memberAnnotations {
            mapRect = mapRect.union(MKMapRect(origin: MKMapPoint(member.coordinate), size: MKMapSize(width: 0, height: 0)))
        }
        // Stories at the very same spot cannot be pulled apart, so they share a row of cards instead.
        guard max(mapRect.width, mapRect.height) > 2_000 else {
            showCards(for: cluster.memberAnnotations.compactMap { $0 as? VisitPlace }.sorted { $0.order < $1.order })
            return
        }
        
        mapView.deselectAnnotation(cluster, animated: false)
        mapView.setVisibleMapRect(mapRect, edgePadding: UIEdgeInsets(top: 120, left: 70, bottom: 100, right: 70), animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView)
    {
        // Moving from one pin to another deselects the first one before selecting the next.
        DispatchQueue.main.async {
            if mapView.selectedAnnotations.isEmpty {
                self.hideCards()
            }
        }
    }
    
    private func showCards(for places: [VisitPlace])
    {
        guard let first = places.first else { return }
        
        cardStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for (index, place) in places.enumerated() {
            let card = StoryMapCardView()
            card.story = stories[place.order]
            card.pageText = places.count > 1 ? "\(index + 1) / \(places.count)" : nil
            card.onClose = { [weak self] in
                guard let self = self else { return }
                self.mapView.selectedAnnotations.forEach { self.mapView.deselectAnnotation($0, animated: true) }
            }
            
            let page = UIView()
            page.accessibilityIdentifier = "storyCard"
            page.addSubview(card)
            card.anchor(top: page.topAnchor, left: page.leftAnchor, bottom: page.bottomAnchor, right: page.rightAnchor,
                        paddingTop: 0, paddingLeft: 4, paddingBottom: 0, paddingRight: 4,
                        width: 0, height: 0)
            cardStack.addArrangedSubview(page)
            page.widthAnchor.constraint(equalTo: cardScrollView.frameLayoutGuide.widthAnchor).isActive = true
        }
        
        let wasShowingCards = isShowingCards
        isShowingCards = true
        cardScrollView.isHidden = false
        cardScrollView.transform = .identity
        cardScrollView.contentOffset = .zero
        view.layoutIfNeeded()
        keepVisible(first)
        
        guard !wasShowingCards else { return }
        cardScrollView.alpha = 0
        cardScrollView.transform = CGAffineTransform(translationX: 0, y: cardScrollView.bounds.height + 40)
        UIView.animate(withDuration: 0.45, delay: 0, usingSpringWithDamping: 0.85, initialSpringVelocity: 0, options: [.beginFromCurrentState, .allowUserInteraction]) {
            self.cardScrollView.alpha = 1
            self.cardScrollView.transform = .identity
        }
    }
    
    private func hideCards()
    {
        guard isShowingCards else { return }
        isShowingCards = false
        UIView.animate(withDuration: 0.25, delay: 0, options: [.beginFromCurrentState, .curveEaseIn]) {
            self.cardScrollView.alpha = 0
            self.cardScrollView.transform = CGAffineTransform(translationX: 0, y: self.cardScrollView.bounds.height + 40)
        } completion: { _ in
            if !self.isShowingCards {
                self.cardScrollView.isHidden = true
            }
        }
    }
    
    // Slides the map up when the cards would cover the pin they belong to.
    private func keepVisible(_ annotation: MKAnnotation)
    {
        let point = mapView.convert(annotation.coordinate, toPointTo: view)
        let lowest = cardScrollView.frame.minY - PhotoAnnotationView.side
        guard point.y > lowest else { return }
        
        var center = CGPoint(x: mapView.bounds.midX, y: mapView.bounds.midY)
        center.y += point.y - lowest
        mapView.setCenter(mapView.convert(center, toCoordinateFrom: mapView), animated: true)
    }
}
