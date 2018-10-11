//
//  ViewController.swift
//  ZLSplitTest
//
//  Created by Long on 2018/10/11.
//  Copyright © 2018年 Long. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var touchButton: UIButton = {
        let btn = UIButton(frame: CGRect(origin: view.center, size: CGSize(width: 100, height: 50)))
        btn.center = view.center
        btn.backgroundColor = .red
        btn.setTitle("start plan", for: .normal)
        return btn
    }()
    
    private lazy var alertPlanButton: UIButton = {
        let btn = UIButton(frame: CGRect(origin: CGPoint(x: view.center.x - 50, y: view.center.y + 80), size: CGSize(width: 100, height: 50)))
        btn.backgroundColor = .green
        btn.setTitle("plan info", for: .normal)
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc private func alertPlanInfo() {
        let alertController = UIAlertController(title: "当前选择方案为：\(kCurrentABTestPlan ?? "nil")",
            message: nil, preferredStyle: .alert)
        //显示提示框
        self.present(alertController, animated: true, completion: nil)
        //1s后自动消失
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.presentedViewController?.dismiss(animated: false, completion: nil)
            if kCurrentABTestPlan == "B" {
                print("&&&&&&&&&&&&----plan-B")
            } else if kCurrentABTestPlan == "C" {
                print("&&&&&&&&&&&&----plan-C")
            } else {
                print("&&&&&&&&&&&&----plan-A")
            }
        }
    }
    
    private func setupUI() {
        view.addSubview(touchButton)
        touchButton.addTarget(self, action: #selector(buttonTouchClicked), for: .touchUpInside)
        view.addSubview(alertPlanButton)
        alertPlanButton.addTarget(self, action: #selector(alertPlanInfo), for: .touchUpInside)
    }
    
    @objc private func buttonTouchClicked() {
        abTest()
    }
    
    private func abTest() {
        print("***********--currentABTestPlan--\(kCurrentABTestPlan ?? "nil")")
        print("***********--currentRandomNum--\(kCurrentRandomNum ?? "nil")")
        for index in (1...5000) {
            ZLSplitTest.sharedInstance.runABCTest(probabilities: [0.0, 0.0, 1.0])
            print("***********--当前第\(index)次 currentTestPlan--  \(kCurrentABTestPlan ?? "nil")  -----currentRandomNum--  \(kCurrentRandomNum ?? "nil")")
        }
    }
    
    
}
