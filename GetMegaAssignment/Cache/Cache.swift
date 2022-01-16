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
    private let dateProvider: () -> Date
    private let entryLifetime: TimeInterval
    private let keyTracker = KeyTracker()
    
    init(dateProvider: @escaping () -> Date = Date.init,
         entryLifetime: TimeInterval = 2 * 60 * 60) {
        // entryLifetime -> 2 hours
        self.dateProvider = dateProvider
        self.entryLifetime = entryLifetime
        wrappedValue.delegate = keyTracker
    }
    
    func insert(_ value: Value, forKey key: Key) {
        let date = dateProvider().addingTimeInterval(entryLifetime)
        let entry = Entry(key: key, value: value, expirationDate: date)
        insert(entry)
    }
    
    func value(forKey key: Key) -> Value? {
        let entry = entry(forKey: key)
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
        let key: Key
        let value: Value
        let expirationDate: Date
        
        init(key: Key, value: Value, expirationDate: Date) {
            self.key = key
            self.value = value
            self.expirationDate = expirationDate
        }
    }
    
    final class KeyTracker: NSObject, NSCacheDelegate {
        var keys =  Set<Key>()
        
        func cache(_ cache: NSCache<AnyObject, AnyObject>,
                   willEvictObject obj: Any) {
            guard let entry = obj as? Entry else {
                return
            }
            keys.remove(entry.key)
        }
    }
    
}

extension Cache.Entry: Codable where Key: Codable, Value: Codable {}

extension Cache: Codable where Key: Codable, Value: Codable {
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.singleValueContainer()
        let entries = try container.decode([Entry].self)
        entries.forEach(insert)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(keyTracker.keys.compactMap(entry))
    }
    
    func saveToDisk(
        withName name: String,
        using fileManager: FileManager = .default
    ) throws {
        let folderURLs = fileManager.urls(
            for: .cachesDirectory,
               in: .userDomainMask
        )
        let fileURL = folderURLs[0].appendingPathComponent(name + ".cache")
        let data = try JSONEncoder().encode(self)
        try data.write(to: fileURL)
    }
}


private extension Cache {
    
    func entry(forKey key: Key) -> Entry? {
        guard let entry = wrappedValue.object(forKey: .init(key)) else {
            return nil
        }
        
        guard dateProvider() < entry.expirationDate else {
            removeValue(forKey: key)
            return nil
        }
        return entry
    }
    
    func insert(_ entry: Entry) {
        wrappedValue.setObject(entry, forKey: .init(entry.key))
        keyTracker.keys.insert(entry.key)
    }
}
