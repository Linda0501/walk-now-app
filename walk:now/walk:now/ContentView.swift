//
//  ContentView.swift
//  walk:now
//
//  Created by Megan Zhu on 4/25/20.
//  Copyright © 2020 Megan Zhu. All rights reserved.
//

import SwiftUI
import HealthKit

let healthKitStore:HKHealthStore = HKHealthStore()

struct ContentView: View {
    @State private var selection = 0
 
    var body: some View {
        TabView(selection: $selection){
            Text("First View")
                .font(.title)
                .tabItem {
                    VStack {
                        Image("first")
                        Text("First")
                    }
                }
                .tag(0)
            Text("Second View")
                .font(.title)
                .tabItem {
                    VStack {
                        Image("second")
                        Text("Second")
                    }
                }
                .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

func authorizeHealthKitinApp() {
    let allTypes = Set([HKObjectType.quantityType(forIdentifier: .stepCount)!])


    if !HKHealthStore.isHealthDataAvailable() {
        print("Error occurred")
        return
    }

    healthKitStore.requestAuthorization(toShare: allTypes, read: allTypes) { (success, error) in
        if !success {
            print("Error occured")
        }
    }

}
