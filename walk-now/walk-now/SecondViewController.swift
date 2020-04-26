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
    
    

    @IBOutlet weak var availableSteps: UILabel!
    @IBOutlet weak var panoramaView: GMSPanoramaView!
    override func viewDidLoad() {//view will load
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let panoView = GMSPanoramaView(frame: .zero)
//        self.view = panoView
//
//        panoView.moveNearCoordinate(CLLocationCoordinate2D(latitude: -33.732, longitude: 150.312))
//
//
        panoramaView.moveNearCoordinate(CLLocationCoordinate2D(latitude: 37.8726, longitude: -122.2600))
        panoramaView.delegate = self
        self.availableSteps.text = String(MyVariables.totalSteps - MyVariables.usedSteps)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//    }
    
    func decreaseSteps(stepsTaken: Int) {
        if (MyVariables.totalSteps - MyVariables.usedSteps >= stepsTaken){
            MyVariables.usedSteps += stepsTaken
        } else {
            MyVariables.usedSteps = MyVariables.totalSteps;
            panoramaView.setAllGesturesEnabled(false)
            print("No more steps left. Walk more~")
        }
        self.availableSteps.text = String(MyVariables.totalSteps - MyVariables.usedSteps)
    }


}

extension SecondViewController: GMSPanoramaViewDelegate {
    func panoramaView(_ view: GMSPanoramaView, didMoveTo pan: GMSPanorama?) {
        print("moved")
        decreaseSteps(stepsTaken:1)
    }
}

