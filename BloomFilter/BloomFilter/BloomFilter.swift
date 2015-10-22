//
//  BloomFilter.swift
//  BloomFilter
//
//  Created by Sergey Fedortsov on 22.10.15.
//  Copyright © 2015 Sergey Fedortsov. All rights reserved.
//

import Foundation
import Darwin

public struct BloomFilter<T: HasHashableKey> {
    typealias HashFunction = T -> UInt32 -> UInt32
    
    private var field: [Bool]
    private let seeds: [UInt32]
    private let hashFunction: HashFunction
    init(bitCount: Int, functionCount: Int, hashFunction: HashFunction)
    {
        self.field = [Bool](count: bitCount, repeatedValue: false)
        self.seeds = [UInt32](count: functionCount, valueGenerator: { (_: Int) -> UInt32 in
            return arc4random()
        })
        self.hashFunction = hashFunction
    }
    
    
    mutating func add(entry: T)
    {
        for seed in self.seeds {
            let hash = hashFunction(entry)(seed)
            let bitNumber = hash % UInt32(self.field.count)
            self.field[Int(bitNumber)] = true
        }
    }
    
    func contains(entry: T) -> Bool
    {
        for seed in self.seeds {
            let hash = hashFunction(entry)(seed)
            let bitNumber = hash % UInt32(self.field.count)
            if !self.field[Int(bitNumber)] {
                return false
            }
        }
        return true
    }
}