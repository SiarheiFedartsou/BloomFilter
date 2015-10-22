//
//  Hash.swift
//  BloomFilter
//
//  Created by Sergey Fedortsov on 22.10.15.
//  Copyright © 2015 Sergey Fedortsov. All rights reserved.
//

import Foundation

// https://en.wikipedia.org/wiki/MurmurHash

private func mmix(inout h: UInt32, inout _ k: UInt32)
{
    let m: UInt32 = 0x5bd1e995;
    let r: UInt32 = 24
    
    k = k &* m;
    k ^= k >> r;
    k = k &* m;
    h = h &* m;
    h ^= k;
}

public extension HasHashableKey
{
    func murmurHash2A(seed: UInt32) -> UInt32
    {
        let m: UInt32 = 0x5bd1e995;
        
        let NSData = String(self.key).dataUsingEncoding(NSUTF8StringEncoding)
        var data: UnsafePointer<UInt8> = UnsafePointer<UInt8>((NSData?.bytes)!)
        
        var l = UInt32((NSData?.length)!)
        
        var h: UInt32 = seed
        
        var len = l
        while len >= 4 {
            var k: UInt32 = UnsafePointer<UInt32>(data).memory
            
            mmix(&h, &k)
            
            data = data.successor()
            len -= 4
        }
        
        var t: UInt32 = 0
        switch len {
        case 3: t ^= UInt32(data[2]) << 16; fallthrough
        case 2: t ^= UInt32(data[1]) << 8; fallthrough
        case 1: t ^= UInt32(data[0]);
        default: break
        }
        
        mmix(&h, &t)
        mmix(&h, &l)
        
        h ^= h >> 13
        h = h &* m
        h ^= h >> 15
        
        return h
    }
}
