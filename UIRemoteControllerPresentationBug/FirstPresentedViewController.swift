//
//  FirstPresentedViewController.swift
//  UIRemoteControllerPresentationBug
//
//  Created by Ji,Jason on 8/10/18.
//  Copyright © 2018 Capital One Labs. All rights reserved.
//

import UIKit

class FirstPresentedViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        destination.modalPresentationStyle = .overFullScreen
    }
    
    @IBAction func presentOverFullScreen(_ sender: Any) {
        performSegue(withIdentifier: "presentOverFullScreen", sender: nil)
    }
    
    @IBAction func presentUIActivityViewController(_ sender: Any) {
        let activityViewController = UIActivityViewController(activityItems: ["Some text to share"], applicationActivities: nil)
        activityViewController.modalPresentationStyle = .overFullScreen
        present(activityViewController, animated: true, completion: nil)
    }
    
}
