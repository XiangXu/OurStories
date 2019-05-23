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
            guard let imageName = story?.imageName else { return }
            imageView.image = UIImage(named: imageName)
            locationLabel.text = story?.location
        }
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let contentTextField: UITextView = {
        let tf = UITextView()
        tf.textColor = .white
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.backgroundColor = .lightRed
        return tf
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightRed
        return view
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        layer.cornerRadius = 5.0
        clipsToBounds = true
        
        addSubview(imageView)
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor,
                         paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0,
                         width: 0,height: 300)

        addSubview(contentView)
        contentView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor,
                           paddingTop: 300, paddingLeft: 0, paddingBottom: 0, paddingRight: 0,
                           width: 0, height: 200)

        contentView.addSubview(locationLabel)
        contentView.addSubview(contentTextField)
        locationLabel.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor,
                             paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0,
                             width: 0, height: 30)
        contentTextField.anchor(top: locationLabel.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor,
                                paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0,
                                width: 0, height: 0)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
