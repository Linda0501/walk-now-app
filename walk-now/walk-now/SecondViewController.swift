//
//  SecondViewController.swift
//  walk-now
//
//  Created by Linda Deng on 2020-04-25.
//  Copyright © 2020 Linda Deng. All rights reserved.
//

import UIKit
import GoogleMaps

class SecondViewController: UIViewController, GMSMapViewDelegate {

    @IBOutlet weak var panoramaView: GMSPanoramaView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let panoView = GMSPanoramaView(frame: .zero)
//        self.view = panoView
//
//        panoView.moveNearCoordinate(CLLocationCoordinate2D(latitude: -33.732, longitude: 150.312))
//
//
        
        panoramaView.moveNearCoordinate(CLLocationCoordinate2D(latitude: 37.3317134, longitude: -122.0307466))
        

    }


}

