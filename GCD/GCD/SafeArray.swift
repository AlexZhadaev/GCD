//
//  SafeArray.swift
//  GCD
//
//  Created by Жадаев Алексей on 20.05.2021.
//

import UIKit

// MARK: - Barrier

class SafeArray<Element> {
    private var array = [Element]()
    private let queue = DispatchQueue(label: "DispatchBarrier", attributes: .concurrent)
    
    public func append(element: Element) {
        queue.async(flags: .barrier) {
            self.array.append(element)
        }
    }
    
    public var elements: [Element] {
        var result = [Element]()
        queue.sync {
            result = self.array
        }
        return result
    }
}

// MARK: - DispatchGroup

//let queue = DispatchQueue(label: "Haha, classic", attributes: .concurrent)
//let group = DispatchGroup()
//
//queue.async(group: group) {
//    for i in 0...10 {
//        if i == 10 {
//            print(i)
//        }
//    }
//}
//
//queue.async(group: group) {
//    for i in 0...20 {
//        if i == 20 {
//            print(i)
//        }
//    }
//}
//
//group.notify(queue: .main) {
//    print("Gotcha #1")
//}
//
//let secondGroup = DispatchGroup()
//secondGroup.enter()
//queue.async(group: group) {
//    for i in 0...30 {
//        if i == 30 {
//            print(i)
//            sleep(2)
//            secondGroup.leave()
//        }
//    }
//}
//
//let result = secondGroup.wait(timeout: .now() + 3)
//print(result)
//
//secondGroup.notify(queue: .main) {
//    print("Gotcha #2")
//}
//
//secondGroup.wait()
//print("Unexpected print")
