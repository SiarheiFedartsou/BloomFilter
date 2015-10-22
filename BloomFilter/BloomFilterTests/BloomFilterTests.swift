//
//  BloomFilterTests.swift
//  BloomFilterTests
//
//  Created by Sergey Fedortsov on 22.10.15.
//  Copyright © 2015 Sergey Fedortsov. All rights reserved.
//

import XCTest
@testable import BloomFilter

struct Record {
    let id: UInt32
    let firstName: String
    let lastName: String
}

extension Record: HasHashableKey {
    typealias KeyType = UInt32
    var key: KeyType {
        get {
            return self.id
        }
    }
}


class BloomFilterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testContains() {
        var bloomFilter = BloomFilter<Record>(bitCount: 32, functionCount: 8, hashFunction: Record.jenkinsHash)
        
        let records = [Record](count: 1024) { (i: Int) -> Record in
            return Record(id: arc4random(), firstName: "John", lastName: "Smith")
        }
        
        for record in records {
            bloomFilter.add(record)
        }
        
        for record in records {
            XCTAssertTrue(bloomFilter.contains(record))
        }
    }
    
}
