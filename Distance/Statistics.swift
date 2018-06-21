//
//  Statistics.swift
//  Distance
//
//  Created by David Maitland on 07/06/2018.
//  Copyright © 2018 David Maitland. All rights reserved.
//

import Foundation
import HealthKit

var healthStore: HKHealthStore?

func requestAuthorization() -> Bool {
    
    // Request access to workoutType, distanceCycling
    
    let allTypes = Set([HKObjectType.workoutType(),
                        HKObjectType.quantityType(forIdentifier: .distanceCycling)!])
    
    healthStore!.requestAuthorization(toShare: nil, read: allTypes) { (success, error) in
        if !success {
            print("requestAuthorization failed")
        } else {
            print("requestAuthorization success")
        }
    }
    
    // ToDo: Return success, error
    
    return true

}

func setupHealthStore() {
    
    // Initialise HKHealthStore - is there a better way to do this with the optional?
    
    if (healthStore == nil) {
        healthStore = HKHealthStore()
        print("Assigned a HKHealthStore")
    } else {
        print("We already have a HKHealthStore")
    }
    
    let _ = requestAuthorization()
    
}

func getData(completionHandler:@escaping (Double?)->()) {
    
    if HKHealthStore.isHealthDataAvailable() {
        
        setupHealthStore()
        
        let sampleType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceCycling)

        let query = HKStatisticsQuery(quantityType: sampleType!,
                                      quantitySamplePredicate: nil,
                                      options: .cumulativeSum) { query, result, error in
                                        
                                        if result != nil {
                                            
                                            var total = 0.0
                                            
                                            if let quantity = result?.sumQuantity() {
                                                
                                                // ToDo: Get unit from params
                                                
                                                let unit = HKUnit.mile()
                                                total = quantity.doubleValue(for: unit)
                                                
                                            }
                                            
                                            // ToDo: Learn about Grand Central Dispatch
                                            
                                            DispatchQueue.main.async {
                                                completionHandler(total)
                                            }
                                    
                                        }
                                        
                                    }
        
        healthStore!.execute(query)
        
    } else {
        // ToDo: Display error to user and quit
    }
    
}
