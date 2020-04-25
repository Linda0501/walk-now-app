//
//  FirstViewController.swift
//  walk-now
//
//  Created by Linda Deng on 2020-04-25.
//  Copyright © 2020 Linda Deng. All rights reserved.
//
import UIKit
import HealthKit

class FirstViewController: UIViewController {

    var available = 0 
    var total = 0
    var lastDate = Date() 

    let healthKitStore: HKHealthStore = HKHealthStore()

    func authorizeHealthKitinApp() {
        let allTypes = Set([HKObjectType.quantityType(forIdentifier: .stepCount)!]) 

        if !HKHealthStore.isHealthDataAvailable() {
            print(“Error occurred”)
            return
        }

        healthKitStore.requestAuthorization(toShare: allTypes, read: allTypes) { (success, error) in 
            if !success {
                print(“Error occured”)
            }
        }

    }

    // add IBOutlet for availableSteps and totalSteps UILabels 

    func getSteps(completion: @escaping (Double) -> Void) {
        
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        
        let now = Date()
        let predicate = HKQuery.predicateForSamples(withStart: lastDate, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (_, result, error) in
            var resultCount = 0.0
            guard let result = result else {
                print("Failed to fetch steps rate")
                completion(resultCount)
                return
            }
            if let sum = result.sumQuantity() {
                resultCount = sum.doubleValue(for: HKUnit.count())
			    available += resultCount
                total += resultCount
            }
		    
            lastDate = now 
            self.totalSteps.text = total
            self.availableSteps.text = available
            
            DispatchQueue.main.async {
                completion(resultCount)
            }
        }
        healthStore.execute(query)
    }

      override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        authorizeHealthKitinApp()
        getSteps()
    }
    
}

