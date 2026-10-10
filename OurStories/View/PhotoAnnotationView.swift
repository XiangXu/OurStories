//
//  PhotoAnnotationView.swift
//  OurStories
//

import UIKit
import MapKit

/// A story on the map, drawn as its photo. Stories that would overlap are grouped
/// into one photo with a count badge.
class PhotoAnnotationView: MKAnnotationView
{
    static let side: CGFloat = 58
    static let clusteringIdentifier = "story"

    private static let thumbnails = NSCache<NSString, UIImage>()

    private var imageName: String?

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.layer.cornerCurve = .continuous
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .tertiarySystemFill
        return imageView
    }()

    private let plate: UIView = {
        let plate = UIView()
        plate.backgroundColor = .cardBackground
        plate.layer.cornerRadius = 11
        plate.layer.cornerCurve = .continuous
        return plate
    }()

    let countBadge: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .rose
        configuration.baseForegroundColor = .white
        configuration.cornerStyle = .capsule
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 7, bottom: 2, trailing: 7)
        let badge = UIButton(configuration: configuration)
        badge.isUserInteractionEnabled = false
        badge.isHidden = true
        return badge
    }()

    override var annotation: MKAnnotation?
    {
        didSet { configure() }
    }

    override init(annotation: MKAnnotation?, reuseIdentifier: String?)
    {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setupViews()
        configure()
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews()
    {
        frame = CGRect(x: 0, y: 0, width: PhotoAnnotationView.side, height: PhotoAnnotationView.side)
        collisionMode = .rectangle
        canShowCallout = true

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 2)

        // The photo sits on a plate that shows around it as a frame.
        addSubview(plate)
        plate.frame = bounds
        plate.addSubview(imageView)
        imageView.frame = bounds.insetBy(dx: 3, dy: 3)

        addSubview(countBadge)
        countBadge.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor,
                          paddingTop: -8, paddingLeft: 0, paddingBottom: 0, paddingRight: -8,
                          width: 0, height: 22)
    }

    private func configure()
    {
        var place = annotation as? VisitPlace
        var count = 1
        if let cluster = annotation as? MKClusterAnnotation {
            let places = cluster.memberAnnotations.compactMap { $0 as? VisitPlace }
            // Show the earliest story of the group, so the photo does not change at random.
            place = places.min { $0.order < $1.order }
            count = places.count
            clusteringIdentifier = nil
            displayPriority = .required
        } else {
            clusteringIdentifier = PhotoAnnotationView.clusteringIdentifier
            displayPriority = .defaultHigh
        }

        var configuration = countBadge.configuration
        configuration?.attributedTitle = AttributedString("\(count)", attributes: AttributeContainer([
            .font: UIFont.systemFont(ofSize: 12, weight: .bold)
        ]))
        countBadge.configuration = configuration
        countBadge.isHidden = count < 2

        showThumbnail(named: place?.imageName)
    }

    // The photos are far larger than a pin, so scale them down once, off the main thread.
    private func showThumbnail(named name: String?)
    {
        guard name != imageName else { return }
        imageName = name
        imageView.image = nil
        guard let name = name else { return }

        if let cached = PhotoAnnotationView.thumbnails.object(forKey: name as NSString) {
            imageView.image = cached
            return
        }

        let side = PhotoAnnotationView.side * traitCollection.displayScale
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let image = UIImage(named: name) else { return }
            let scale = side / min(image.size.width, image.size.height)
            let size = CGSize(width: image.size.width * scale, height: image.size.height * scale)
            guard let thumbnail = image.preparingThumbnail(of: size) else { return }
            PhotoAnnotationView.thumbnails.setObject(thumbnail, forKey: name as NSString)
            DispatchQueue.main.async {
                guard let self = self, self.imageName == name else { return }
                self.imageView.image = thumbnail
            }
        }
    }
}
