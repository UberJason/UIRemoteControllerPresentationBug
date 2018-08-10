//
//  BlurPresentationTransitioningDelegate.swift
//  GiftgramKit
//
//  Created by Ji,Jason on 9/28/17.
//  Copyright © 2017 Capital One Labs. All rights reserved.
//

import UIKit
public class BlurPresentationTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    public let params: BlurPresentationParams
    
    public init(params: BlurPresentationParams = BlurPresentationParams()) {
        self.params = params
    }
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BlurPresentationAnimator(params: params, transitionType: .present)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BlurPresentationAnimator(params: params, transitionType: .dismiss)
    }
    
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return BlurPresentationController(params: params, presentedViewController: presented, presentingViewController: presenting)
    }
}
