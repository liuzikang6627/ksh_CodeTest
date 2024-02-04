//
//  main.swift
//  CodeTest1
//
//  Created by 刘子康 on 2024/2/4.
//

import Foundation

typealias Interval = Array<Int>

func attend(meetings: Array<Interval>?) -> Bool {
    print("input: \(String(describing: meetings))")
    var isOverlap: Bool = false
    let intervals: Array<Interval> = meetings ?? Array<Interval>()
    
    for (idx, interval) in intervals.enumerated() {
        guard interval.count >= 2 else { continue }
        // 取一个时间都与其他时间段做对比
        let currentStartVal: Int = interval[0]
        let currentStopVal: Int = interval[1]
        let currentHasCrossDay: Bool = currentStopVal <= currentStartVal
        // 遍历其余时间段
        var otherInterVals = intervals.map { $0 }
        otherInterVals.remove(at: idx)
        for otherInterVal in otherInterVals {
            guard otherInterVal.count >= 2 else { continue }
            let otherStartVal: Int = otherInterVal[0]
            let otherStopVal: Int = otherInterVal[1]
            let otherHasCrossDay: Bool = otherStopVal <= otherStartVal
            var result: Bool = false
            // 先判断是否有跨天
            if currentHasCrossDay && otherHasCrossDay {
                // 跨天: 时间段重叠了
                result = true
            } else {
                // 没跨天：再判断
                result = otherStartVal <= currentStopVal && currentStartVal <= otherStopVal
            }
            // 只要有一次重叠了，直接返回重叠
            if result {
                isOverlap = true
                break
            }
        }
        if isOverlap {
            break
        }
    }
    
    if isOverlap {
        return false
    }
    return true
}


var intervals: Array<Interval> = Array<Interval>()

intervals.append(contentsOf: [
    [0, 30],
    [5, 10],
    [15, 20]
])

//intervals.append(contentsOf: [
//    [7, 10],
//    [2, 4]
//])

//intervals.append(contentsOf: [
//    [1, 5],
//    [8, 9],
//    [8, 10]
//])

let result = attend(meetings: intervals)
print("Question: The person could attend all meetings?")
print("Answer: \(result ? "true" : "false")")
