//
//  Card.swift
//  OurStories
//
//  Created by Xiang Xu on 23/05/2019.
//  Copyright © 2019 Xiang Xu. All rights reserved.
//

import UIKit

class CardView: UIView
{
    var story: Story?{
        didSet{
            guard let story = story else { return }
            imageView.image = UIImage(named: story.imageName)
            locationLabel.text = story.location
        }
    }

    /// Shown in the corner of the photo, e.g. "3 / 59".
    var pageText: String? {
        didSet{
            var configuration = pageBadge.configuration
            configuration?.attributedTitle = AttributedString(pageText ?? "", attributes: AttributeContainer([
                .font: UIFont.monospacedDigitSystemFont(ofSize: 12, weight: .semibold)
            ]))
            pageBadge.configuration = configuration
            pageBadge.isHidden = pageText == nil
        }
    }

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .tertiarySystemFill
        return imageView
    }()

    let pageBadge: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = UIColor.black.withAlphaComponent(0.45)
        configuration.baseForegroundColor = .white
        configuration.cornerStyle = .capsule
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        let badge = UIButton(configuration: configuration)
        badge.isUserInteractionEnabled = false
        badge.isHidden = true
        return badge
    }()

    let locationIcon: UIImageView = {
        let configuration = UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)
        let imageView = UIImageView(image: UIImage(systemName: "mappin.circle.fill", withConfiguration: configuration))
        imageView.tintColor = .rose
        imageView.contentMode = .center
        return imageView
    }()

    let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .titleText
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        return label
    }()

    let contentTextField: TypeOnTextView = {
        let tf = TypeOnTextView()
        tf.isUserInteractionEnabled = false
        tf.textColor = .bodyText
        tf.backgroundColor = .clear
        tf.font = UIFont.systemFont(ofSize: 16)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        tf.typeOnAttributes = [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.bodyText, .paragraphStyle: paragraphStyle]
        tf.textContainerInset = .zero
        tf.textContainer.lineFragmentPadding = 0
        return tf
    }()

    // Clips the photo to the rounded corners; the card itself stays unclipped so its shadow shows.
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .cardBackground
        view.layer.cornerRadius = 24
        view.layer.cornerCurve = .continuous
        view.layer.masksToBounds = true
        return view
    }()

    override init(frame: CGRect)
    {
        super.init(frame: frame)

        layer.shadowColor = UIColor.rgb(red: 90, green: 40, blue: 50).cgColor
        layer.shadowOpacity = 0.16
        layer.shadowRadius = 14
        layer.shadowOffset = CGSize(width: 0, height: 8)

        addSubview(contentView)
        contentView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor,
                           paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0,
                           width: 0, height: 0)

        contentView.addSubview(imageView)
        imageView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor,
                         paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0,
                         width: 0, height: 0)
        imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.52).isActive = true

        contentView.addSubview(pageBadge)
        pageBadge.anchor(top: contentView.topAnchor, left: nil, bottom: nil, right: contentView.rightAnchor,
                         paddingTop: 14, paddingLeft: 0, paddingBottom: 0, paddingRight: 14,
                         width: 0, height: 0)

        contentView.addSubview(locationIcon)
        contentView.addSubview(locationLabel)
        contentView.addSubview(contentTextField)
        locationIcon.anchor(top: imageView.bottomAnchor, left: contentView.leftAnchor, bottom: nil, right: nil,
                            paddingTop: 18, paddingLeft: 20, paddingBottom: 0, paddingRight: 0,
                            width: 24, height: 30)
        locationLabel.anchor(top: imageView.bottomAnchor, left: locationIcon.rightAnchor, bottom: nil, right: contentView.rightAnchor,
                             paddingTop: 18, paddingLeft: 8, paddingBottom: 0, paddingRight: 20,
                             width: 0, height: 30)
        contentTextField.anchor(top: locationLabel.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor,
                                paddingTop: 12, paddingLeft: 20, paddingBottom: 18, paddingRight: 20,
                                width: 0, height: 0)
    }

    override func layoutSubviews()
    {
        super.layoutSubviews()
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
