//
//  BlurPresentationController.swift
//  GiftgramKit
//
//  Created by Ji,Jason on 9/28/17.
//  Copyright © 2017 Capital One Labs. All rights reserved.
//

import UIKit

public class BlurPresentationController: UIPresentationController {
    let params: BlurPresentationParams
    
    let dimmingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.isUserInteractionEnabled = true
        return view
    }()
    
    lazy var gestureRecognizer: UITapGestureRecognizer = {
        var gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dimmingViewTapped(recognizer:)))
        return gestureRecognizer
    }()
    
    let blurEffect = UIBlurEffect(style: .light)
    let visualEffectView = UIVisualEffectView()
    
    public init(params: BlurPresentationParams, presentedViewController presented: UIViewController, presentingViewController presenting: UIViewController?) {
        self.params = params
        super.init(presentedViewController: presented, presenting: presenting)
        dimmingView.addGestureRecognizer(gestureRecognizer)
    }
    
    public override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    public override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { print("No container view for this presentation controller?!"); return .zero }
        let insetWidth = params.presentedViewInsets.left + params.presentedViewInsets.right
        let insetHeight = params.presentedViewInsets.top + params.presentedViewInsets.bottom
        return CGRect(x: params.presentedViewInsets.left, y: params.presentedViewInsets.top, width: containerView.frame.size.width - insetWidth, height: containerView.frame.size.height - insetHeight)
    }
    
    public override func presentationTransitionWillBegin() {
        if let containerView = containerView, let presentedView = presentedView {
            dimmingView.frame = containerView.bounds
            dimmingView.alpha = 0.0
            
            containerView.addSubviewFullFrame(visualEffectView)
            containerView.addSubview(dimmingView)
            containerView.addSubview(presentedView)
            
            let transitionCoordinator = presentingViewController.transitionCoordinator
            transitionCoordinator?.animate(alongsideTransition: { (context) in
                self.dimmingView.alpha = self.params.maxDimmedAlpha
                self.visualEffectView.effect = self.blurEffect
            }, completion: { (context) in
                
            })
        }
    }
    public override func presentationTransitionDidEnd(_ completed: Bool) {
        if !completed {
            dimmingView.removeFromSuperview()
        }
    }
    
    public override func dismissalTransitionWillBegin() {
        let transitionCoordinator = presentingViewController.transitionCoordinator
        transitionCoordinator?.animate(alongsideTransition: { (context) in
            self.dimmingView.alpha = 0.0
            self.visualEffectView.effect = nil
        }, completion: { (context) in
            
        })
    }
    
    public override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            dimmingView.removeFromSuperview()
            visualEffectView.removeFromSuperview()
        }
        else {
            dimmingView.alpha = params.maxDimmedAlpha
            visualEffectView.effect = blurEffect
        }
    }
    
    @objc func dimmingViewTapped(recognizer: UITapGestureRecognizer) {
        NotificationCenter.default.post(name: .blurDimmingViewTapped, object: nil)
    }
}


public extension Notification.Name {
    public static let blurDimmingViewTapped = Notification.Name("blurDimmingViewTapped")
}

extension UIView {
    public func addSubviewFullFrame(_ subview: UIView, with insets: UIEdgeInsets = .zero, at index: Int? = nil, layoutImmediately: Bool = true) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        if let index = index {
            insertSubview(subview, at: index)
        }
        else {
            addSubview(subview)
        }
        
        subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left).isActive = true
        subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1*insets.right).isActive = true
        subview.topAnchor.constraint(equalTo: topAnchor, constant: insets.top).isActive = true
        subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1*insets.bottom).isActive = true
        
        if layoutImmediately {
            layoutIfNeeded()
        }
    }
}
