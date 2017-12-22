//
//  ExampleTests.swift
//  ExampleTests
//
//  Created by Bell App Lab on 22.12.17.
//  Copyright © 2017 Bell App Lab. All rights reserved.
//

import XCTest


class Test: CustomStringConvertible {
    var description: String {
        return "TEST"
    }
}

class TestWithString: CustomStringConvertible {
    private let _description: String
    
    init(description: String) {
        _description = description
    }
    
    var description: String {
        return _description
    }
}


class ExampleTests: XCTestCase
{
    func testExample() {
        var test: Test? = Test()
        let weakTest = Weak(test!)
        
        XCTAssertNotNil(weakTest.value, "Underlaying weak value shouldn't be nil")
        XCTAssertEqual(weakTest.value?.description, "TEST", "A Test object should print out TEST")
        
        test = nil
        
        XCTAssertNil(weakTest.value, "Underalying weak value should be nil")
        
        test = Test()
        let weakOptional = ≈test
        
        XCTAssertNotNil(weakOptional, "Weak variable shouldn't be nil")
        XCTAssertNotNil(weakOptional?.value, "Underlaying weak value shouldn't be nil")
        XCTAssertEqual(weakOptional?.value?.description, "TEST", "A Test object should print out TEST")
        
        test = nil
        
        XCTAssertNil(weakOptional?.value, "Underalying weak value should be nil")
    }
    
    func testAnySequence() {
        var tests = (1...10).map { TestWithString(description: "TEST \($0)") }
        
        let testsCount = tests.count
        
        let strings = ["TEST 1", "TEST 2", "TEST 3", "TEST 4", "TEST 5", "TEST 6", "TEST 7", "TEST 8", "TEST 9", "TEST 10"]
        XCTAssertEqual(strings.count, tests.count, "Both the 'tests' array and the 'strings' array should have the same number of elements")
        
        var tempStrings = strings
        var tempTests = tests
        while !tempStrings.isEmpty {
            let string = tempStrings.removeLast()
            tempTests = tempTests.filter { $0.description != string }
        }
        XCTAssertEqual(tempStrings.count, tempTests.count, "Both the 'tests' array and the 'strings' array should have the same number of elements")
        XCTAssertEqual(tempStrings.count, 0, "The 'tempStrings' array should have zero elements")
        XCTAssertEqual(tempTests.count, 0, "The 'tempTests' array should have zero elements")
        
        var weakTests = tests.map { ≈$0 }
        
        XCTAssertEqual(tests.count, weakTests.count, "Both the 'tests' array and the 'weakTests' array should have the same number of elements")
        
        tests.removeLast()
        
        XCTAssertEqual(tests.count, testsCount - 1, "The 'tests' array should have one less element")
        XCTAssertEqual(weakTests.count, testsCount, "The 'weakTests' array shouldn't have changed")
        
        weakTests = weakTests.flattenedWeaks()
        
        XCTAssertEqual(weakTests.count, testsCount - 1, "The flattened 'weakTests' array should have one less element")
    }
}
