//
//  Cache.swift
//  GetMegaAssignment
//
//  Created by sanket kumar on 16/01/22.
//

import Foundation
import UIKit

final class Cache<Key: Hashable, Value> {
    
    private let wrappedValue = NSCache<WrappedKey, Entry>()
    
    func insert(_ value: Value, forKey key: Key) {
        let entry = Entry(value: value)
        wrappedValue.setObject(entry, forKey: .init(key))
    }
    
    func value(forKey key: Key) -> Value? {
        let entry = wrappedValue.object(forKey: .init(key))
        return entry?.value
    }
    
    func removeValue(forKey key: Key) {
        wrappedValue.removeObject(forKey: .init(key))
    }
}

extension Cache {
    subscript(key: Key) -> Value? {
        get { value(forKey: key) }
        set {
            guard let value = newValue else {
                // If nil was assigned using our subscript,
                // then we remove any value for that key:
                removeValue(forKey: key)
                return
            }
            insert(value, forKey: key)
        }
    }
    
}

private extension Cache {
    
    final class WrappedKey: NSObject {
        let key: Key
        
        init(_ key: Key) {
            self.key = key
        }
        
        override var hash: Int {
            key.hashValue
        }
        
        override func isEqual(_ object: Any?) -> Bool {
            guard let val = object as? WrappedKey else
            { return false }
            return val.key == key
        }
    }
    
    final class Entry {
        let value: Value
        
        init(value: Value) {
            self.value = value
        }
    }
    
}
