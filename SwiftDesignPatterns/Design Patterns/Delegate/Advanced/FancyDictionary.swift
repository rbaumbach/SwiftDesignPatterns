import Foundation

protocol FancyDictionaryDelegate: class {
    associatedtype Key
    associatedtype Value
    
    func didAdd(key: Key, value: Value)
    func didRemove(key: Key)
}

struct FancyDictionary<T: Hashable, U> {
    // MARK: - Private Propteries
    
    private var dictionary: [T: U] = [:]
    
    // MARK: - Public Properties
    
    weak var delegate: AnyFancyDictionaryDelegate<T, U>?
    
    // MARK: - Public Methods
    
    subscript(key: T) -> U? {
        get {
            return dictionary[key]
        }
        set(newValue) {
            if let newValue = newValue {
                delegate?.didAdd(key: key, value: newValue)
            } else {
                delegate?.didRemove(key: key)
            }
            
            dictionary[key] = newValue
        }
    }
}
