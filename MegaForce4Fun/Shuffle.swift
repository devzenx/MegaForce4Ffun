//
//  Shuffle.swift
//  MegaForce4Fun
//
//  Created by Stéphane DEPOILLY on 12/04/2016.
//  Copyright © 2016 Stéphane DEPOILLY. All rights reserved.
//

import Foundation


// This code must be written outside a class, that's why it has been written in a seperate file.
// It allows to shuffle the order of items in a array.

// Fisher-Yates shuffle as protocol extensions

extension CollectionType {
    /// Return a copy of `self` with its elements shuffled
    func shuffle() -> [Generator.Element] {
        var list = Array(self)
        list.shuffleInPlace()
        return list
    }
}

extension MutableCollectionType where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffleInPlace() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in 0..<count - 1 {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}