//
//  JenkinsHash.swift
//  BloomFilter
//
//  Created by Sergey Fedortsov on 22.10.15.
//  Copyright © 2015 Sergey Fedortsov. All rights reserved.
//

import Foundation

public extension HasHashableKey
{
    func jenkinsHash(seed: UInt32) -> UInt32
    {
        let NSData = String(self.key).dataUsingEncoding(NSUTF8StringEncoding)
        let data: UnsafePointer<UInt8> = UnsafePointer<UInt8>((NSData?.bytes)!)
        let keyLength = (NSData?.length)!
        
        var hash = seed
        for i in 0..<keyLength {
            hash = hash &+ UInt32(data[i])
            hash = hash &+ (hash << 10)
            hash ^= hash >> 6
        }
        
        hash = hash &+ (hash << 3)
        hash ^= hash >> 11
        hash = hash &+ (hash << 15)
        
        return hash
    }
}