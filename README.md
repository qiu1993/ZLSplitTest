# ZLSplitTest

# 项目简介

适用于对ABTest、ABCTest的需求。

# 使用方法

```
ZLSplitTest.sharedInstance.runABCTest(probabilities: [0.0, 0.0, 1.0])
ZLSplitTest.sharedInstance.runABTest(distribution: [0.4, 0.6])

```

```
// 判断当前使用plan type
if kCurrentABTestPlan == "B" {
                print("&&&&&&&&&&&&----plan-B")
            } else if kCurrentABTestPlan == "C" {
                print("&&&&&&&&&&&&----plan-C")
            } else {
                print("&&&&&&&&&&&&----plan-A")
            }
```
