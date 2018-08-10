//
//  BlurPresentationParams.swift
//  GiftgramKit
//
//  Created by Ji,Jason on 9/29/17.
//  Copyright © 2017 Capital One Labs. All rights reserved.
//

import UIKit

public struct BlurPresentationParams {
    public let duration: TimeInterval
    public let maxDimmedAlpha: CGFloat
    public let presentedCornerRadius: CGFloat
    public let presentedViewInsets: UIEdgeInsets
    
    public init(duration: TimeInterval = 0.4, maxDimmedAlpha: CGFloat = 0.5, presentedCornerRadius: CGFloat = 12.0, presentedViewInsets: UIEdgeInsets = .zero) {
        self.duration = duration
        self.maxDimmedAlpha = maxDimmedAlpha
        self.presentedCornerRadius = presentedCornerRadius
        self.presentedViewInsets = presentedViewInsets
    }
}
