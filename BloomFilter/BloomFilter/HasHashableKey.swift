//
//  HasKey.swift
//  BloomFilter
//
//  Created by Sergey Fedortsov on 22.10.15.
//  Copyright © 2015 Sergey Fedortsov. All rights reserved.
//

import Foundation

public protocol HasHashableKey
{
    typealias KeyType
    var key: KeyType { get }
}
