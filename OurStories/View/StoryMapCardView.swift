//
//  StoryMapCardView.swift
//  OurStories
//

import UIKit

/// The card that floats over the bottom of the map for the selected story:
/// its photo, place and date, with the whole story underneath.
class StoryMapCardView: UIView
{
    var onClose: (() -> Void)?

    var story: Story? {
        didSet{
            guard let story = story else { return }
            imageView.image = UIImage(named: story.imageName)
            locationLabel.text = story.location
            // "$" only pauses the typewriter on the deck, so it is not part of the printed text.
            let text = TypeOnTextView.typeOnSteps(for: story.storyContent).joined()
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 5
            textLabel.attributedText = NSAttributedString(string: text, attributes: [
                .font: UIFont.systemFont(ofSize: 15), .foregroundColor: UIColor.bodyText, .paragraphStyle: paragraphStyle
            ])
            updateDetail()
        }
    }

    /// Position among the stories of the same place, e.g. "1 / 3"; nil for a story on its own.
    var pageText: String? {
        didSet{ updateDetail() }
    }

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.layer.cornerCurve = .continuous
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .tertiarySystemFill
        return imageView
    }()

    let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .titleText
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        return label
    }()

    let detailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .rose
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        return label
    }()

    let textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

    lazy var closeButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.image = UIImage(systemName: "xmark",
                                      withConfiguration: UIImage.SymbolConfiguration(pointSize: 11, weight: .bold))
        configuration.baseBackgroundColor = .tertiarySystemFill
        configuration.baseForegroundColor = .bodyText
        configuration.cornerStyle = .capsule
        let button = UIButton(configuration: configuration)
        button.accessibilityIdentifier = "closeStoryCard"
        button.accessibilityLabel = "关闭"
        button.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
        return button
    }()

    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .cardBackground
        view.layer.cornerRadius = 20
        view.layer.cornerCurve = .continuous
        return view
    }()

    override init(frame: CGRect)
    {
        super.init(frame: frame)

        layer.shadowColor = UIColor.rgb(red: 90, green: 40, blue: 50).cgColor
        layer.shadowOpacity = 0.22
        layer.shadowRadius = 12
        layer.shadowOffset = CGSize(width: 0, height: 6)

        addSubview(contentView)
        contentView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor,
                           paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0,
                           width: 0, height: 0)

        let titleStack = UIStackView(arrangedSubviews: [locationLabel, detailLabel])
        titleStack.axis = .vertical
        titleStack.spacing = 5

        contentView.addSubview(imageView)
        contentView.addSubview(closeButton)
        contentView.addSubview(titleStack)
        contentView.addSubview(textLabel)
        imageView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: nil,
                         paddingTop: 14, paddingLeft: 14, paddingBottom: 0, paddingRight: 0,
                         width: 68, height: 68)
        closeButton.anchor(top: contentView.topAnchor, left: nil, bottom: nil, right: contentView.rightAnchor,
                           paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 10,
                           width: 28, height: 28)
        titleStack.anchor(top: nil, left: imageView.rightAnchor, bottom: nil, right: closeButton.leftAnchor,
                          paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 8,
                          width: 0, height: 0)
        titleStack.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        textLabel.anchor(top: imageView.bottomAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor,
                         paddingTop: 12, paddingLeft: 16, paddingBottom: 0, paddingRight: 16,
                         width: 0, height: 0)
        // A card next to a longer story is stretched to match it; its own text stays at the top.
        textLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16).isActive = true
        let hugsText = textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        hugsText.priority = .defaultLow
        hugsText.isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews()
    {
        super.layoutSubviews()
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
    }

    private func updateDetail()
    {
        let details = [story?.date?.displayText, pageText].compactMap { $0 }
        detailLabel.text = details.joined(separator: "  ·  ")
        detailLabel.isHidden = details.isEmpty
    }

    @objc private func handleClose()
    {
        onClose?()
    }
}
