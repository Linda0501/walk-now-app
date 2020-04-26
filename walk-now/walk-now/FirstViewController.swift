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

    public var available = 0.0
    var total = 10
    var lastDate = Date() 

    let healthKitStore: HKHealthStore = HKHealthStore()
    @IBOutlet weak var availableSteps: UILabel!
    @IBOutlet weak var totalSteps: UILabel!

    //@IBAction
    func authoriseHealthKitAccess() {
        let healthKitTypes: Set = [
            // access step count
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        ]
        healthKitStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { (_, _) in
            print("authrised???")
        }
        healthKitStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { (bool, error) in
            if let e = error {
                print("oops something went wrong during authorisation \(e.localizedDescription)")
            } else {
                print("User has completed the authorization flow")
            }
        }
    }
//    func authorizeHealthKitinApp() {
//        let allTypes = Set([HKObjectType.quantityType(forIdentifier: .stepCount)!])
//
//
//        if !HKHealthStore.isHealthDataAvailable() {
//            print("Error occured")
//            return
//        }
//
//        healthKitStore.requestAuthorization(toShare: allTypes, read: allTypes) { (success, error) in
//            if !success {
//                print("Error occured")
//            }
//        }
//
//    }

    // add IBOutlet for availableSteps and totalSteps UILabels 

//    func getSteps(completion: @escaping (Double) -> Void) {
//
//        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
//
//        let now = Date()
//        let predicate = HKQuery.predicateForSamples(withStart: lastDate, end: now, options: .strictStartDate)
//
//        let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (_, result, error) in
//            var resultCount = 0.0
//            guard let result = result else {
//                print("Failed to fetch steps rate")
//                completion(resultCount)
//                return
//            }
//            if let sum = result.sumQuantity() {
//                resultCount = sum.doubleValue(for: HKUnit.count())
//                self.available += resultCount
//                self.total += resultCount
//            }
//
//            //self.lastDate = now
//            //self.totalSteps.text = total
//            //self.availableSteps.text = available
//
//            DispatchQueue.main.async {
//                completion(resultCount)
//            }
//        }
//        self.healthKitStore.execute(query)
//    }
    
    func getTodaysSteps(completion: @escaping (Int) -> Void) {
        
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (_, result, error) in
            //var resultCount = 0.0
            guard let result = result else {
                print("Failed to fetch steps rate")
                completion(MyVariables.totalSteps)
                return
            }
            if let sum = result.sumQuantity() {
                MyVariables.totalSteps += Int(sum.doubleValue(for: HKUnit.count()))
            }
            
            DispatchQueue.main.async {
                completion(MyVariables.totalSteps)
            }
        }
        healthKitStore.execute(query)
    }

    
    @IBAction func getTotalSteps(_ sender: Any) {
        getTodaysSteps { (result) in
            print("\(result)")
            DispatchQueue.main.async {
                self.totalSteps.text = "\(result)"
            }
        }
    }
    
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
        
        authoriseHealthKitAccess()
        
        }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getTodaysSteps { (result) in
            print("\(result)")
            DispatchQueue.main.async {
                self.totalSteps.text = "\(result)"
            }
        }
        DispatchQueue.main.async {
            self.availableSteps.text = String(MyVariables.totalSteps - MyVariables.usedSteps)//want to display total steps
        }
    }
    
}
struct MyVariables {
    static var totalSteps = 20
    static var usedSteps = 0
}

