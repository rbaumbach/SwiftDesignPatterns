import Foundation

// In order to have a "generic" delegate that can be used for a generic data structure such as a Dictionary
// we must use Type Erasure.  See Type Erasure pattern for more information

class AnyFancyDictionaryDelegate<Key, Value>: FancyDictionaryDelegate {
    private let box: AnyFancyDictionaryDelegateBase<Key, Value>
    
    init<T: FancyDictionaryDelegate>(_ concrete: T) where T.Key == Key, T.Value == Value  {
        box = AnyFancyDictionaryDelegateBox(concrete)
    }
    
    func didAdd(key: Key, value: Value) {
        box.didAdd(key: key, value: value)
    }
    
    func didRemove(key: Key) {
        box.didRemove(key: key)
    }
}

// MARK: - Private Classes

private class AnyFancyDictionaryDelegateBase<Key, Value>: FancyDictionaryDelegate {
    func didAdd(key: Key, value: Value) {
        fatalError("Must override")
    }
    
    func didRemove(key: Key) {
        fatalError("Must override")
    }
}

private class AnyFancyDictionaryDelegateBox<T: FancyDictionaryDelegate>: AnyFancyDictionaryDelegateBase<T.Key, T.Value> {
    var concrete: T
    
    init(_ concrete: T) {
        self.concrete = concrete
    }
    
    override func didAdd(key: T.Key, value: T.Value) {
        concrete.didAdd(key: key, value: value)
    }
    
    override func didRemove(key: T.Key) {
        concrete.didRemove(key: key)
    }
}
