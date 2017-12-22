//
//  Weak.swift
//  Example
//
//  Created by Bell App Lab on 22.12.17.
//  Copyright © 2017 Bell App Lab. All rights reserved.
//

import Foundation


public protocol Weakable {
    associatedtype WeakValue: AnyObject
    init(_ value: WeakValue)
    init?(_ value: WeakValue?)
    var value: WeakValue? { get }
}


public struct Weak<Value: AnyObject>: Weakable {
    public typealias WeakValue = Value
    
    public fileprivate(set) weak var value: Value?
    
    public init(_ value: Value) {
        self.value = value
    }
    
    public init?(_ value: Value?) {
        guard let value = value else { return nil }
        self.init(value)
    }
}


prefix operator ≈
public prefix func ≈<T>(rhs: T?) -> Weak<T>? {
    return Weak(rhs)
}
public prefix func ≈<T>(rhs: T) -> Weak<T> {
    return Weak(rhs)
}


public extension Collection where Element: Weakable {
    public func unwrappedWeaks() -> [Element.WeakValue] {
        return self.flatMap { $0.value }
    }
    
    public func flattenedWeaks() -> [Element] {
        return self.filter { $0.value != nil }
    }
}
