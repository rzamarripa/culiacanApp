//
//  LoadingView.swift
//  Culiacan
//
//  Created by Diego Mendoza on 9/26/15.
//  Copyright (c) 2015 RedRabbit. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    var titleLabel: UILabel!
    
    var title: String! {
        get {
            return titleLabel.text
        }
        
        set(title) {
            titleLabel.text = title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        layer.cornerRadius = 20
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        let air = frame.size.height * 0.20
        let activity = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
        activity.frame = CGRectMake((frame.size.width - 37) / 2, air, 37, 37)
        activity.startAnimating()
        addSubview(activity)
        
        titleLabel = UILabel(frame: CGRectMake(0, air + 37, frame.size.width, frame.size.height - 57))
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont.systemFontOfSize(14)
        titleLabel.textAlignment = .Center
        titleLabel.lineBreakMode = .ByWordWrapping
        titleLabel.numberOfLines = 0
        // TODO: Localizable
        titleLabel.text = "Loading ..."
        addSubview(titleLabel)
    }
    
}
