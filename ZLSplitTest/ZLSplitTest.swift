//
//  ZLSplitTest.swift
//  ABKit
//
//  Created by Long on 2018/9/20.
//  Copyright © 2016 Long. All rights reserved.
//

import Foundation

public var kCurrentABTestPlan: String? {
    get {
        return UserDefaults.standard.string(forKey: "ABKit-CurrentABTestPlan")
    }
}
public var kCurrentRandomNum: String? {
    get {
        return UserDefaults.standard.string(forKey: "ABKit-randomNum")
    }
}

class ZLSplitTest {
    
    static let sharedInstance = ZLSplitTest()
    private init() {}
    
    // Constants
    private let kGroupPlan = "ABKit-CurrentABTestPlan"
    private let kGroupNum = "ABKit-randomNum"
    private let kGroupA = "A"
    private let kGroupB = "B"
    private let kGroupC = "C"

    public func runABTest(distribution: [Double]=[0.5,0.5]) {
        let isNil = _isKSplitGroupKeyAndNumNil()
        if isNil == true {
            let rnd = _randomNumber(probabilities: distribution)
            if rnd == 0 {
                _saveGroupPlanType(group: kGroupA)
            } else {
                _saveGroupPlanType(group: kGroupB)
            }
        } else {
           return
        }
    }

    public func runABCTest(probabilities: [Double]=[0.33, 0.33, 0,33]) {
        let isNil = _isKSplitGroupKeyAndNumNil()
        if isNil == true {
            let rnd = _randomNumber(probabilities: probabilities)
            if rnd == 0 {
                _saveGroupPlanType(group: kGroupA)
            } else if rnd == 1 {
                _saveGroupPlanType(group: kGroupB)
            } else {
                _saveGroupPlanType(group: kGroupC)
            }
        } else {
            return
        }
    }
    
    // Whether the test has been executed locally
    private func _isKSplitGroupKeyAndNumNil() -> Bool? {
        let planType = UserDefaults.standard.string(forKey: "ABKit-CurrentABTestPlan")
        let num = UserDefaults.standard.string(forKey: "ABKit-randomNum")
        return (planType == nil || num == nil) ? true: false
    }
    
    // Store the currently executing Test type
    private func _saveGroupPlanType(group: String) {
        let defaults = UserDefaults.standard
        defaults.setValue(group, forKey: kGroupPlan)
        defaults.synchronize()
    }

    // Store the currently executing RandomNum
    private func _saveGroupRandomNum(randomNum: String) {
        let defaults = UserDefaults.standard
        defaults.setValue(randomNum, forKey: kGroupNum)
        defaults.synchronize()
    }
    
    /**
     * Create a random number with distribution
     * E.g. randomNumber([0.5,0.5]) generate a 0 or 1 with 50-50 split
     *      randomNumber([0.33,0.33,0.33]) generate 0,1,2 with a 33-33-33 split
     * Credits are going to Martin R. for that method (http://stackoverflow.com/users/1187415/martin-r)
     * Stackoverflow Explanation: http://stackoverflow.com/questions/30309556/generate-random-numbers-with-a-given-distribution
     */
    private func _randomNumber(probabilities: [Double]) -> Int {
        // Sum of all probabilities (so that we don't have to require that the sum is 1.0):
        let sum = probabilities.reduce(0, +)
        //        print("sum_______________________________",sum)
        // Random number in the range 0.0 <= rnd < sum :
        let rnd = Double.random(in: 0.0 ..< sum)
        //        print("rnd_______________________________",rnd)
        _saveGroupRandomNum(randomNum: "\(rnd)")
        // Find the first interval of accumulated probabilities into which `rnd` falls:
        var accum = 0.0
        for (i, p) in probabilities.enumerated() {
            accum += p
            if rnd < accum {
                return i
            }
        }
        // This point might be reached due to floating point inaccuracies:
        return (probabilities.count - 1)
    }
}
