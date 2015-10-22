//
//  ArrayValueGeneratorExtension.swift
//  BloomFilter
//
//  Created by Sergey Fedortsov on 22.10.15.
//  Copyright © 2015 Sergey Fedortsov. All rights reserved.
//

import Foundation


extension Array
{
    init(count: Int, valueGenerator: Int -> Element)
    {
        var array: [Element] = []
        for i in 0..<count {
            array.append(valueGenerator(i))
        }
        self = array
    }
}
