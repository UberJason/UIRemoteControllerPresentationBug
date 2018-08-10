//
//  ViewController.swift
//  UIRemoteControllerPresentationBug
//
//  Created by Ji,Jason on 8/10/18.
//  Copyright © 2018 Capital One Labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    public let transitionDelegate = BlurPresentationTransitioningDelegate(params: BlurPresentationParams(presentedViewInsets: UIEdgeInsets(top: 60, left: 20, bottom: 60, right: 20)))
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        destination.modalPresentationStyle = .custom
        destination.transitioningDelegate = transitionDelegate
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performSegue(withIdentifier: "presentInitial", sender: nil)
    }
}

