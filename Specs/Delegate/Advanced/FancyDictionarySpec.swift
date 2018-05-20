import Quick
import Nimble

@testable import SwiftDesignPatterns

// This is a delegate that we can use to verify that messages are being sent to the delegate object
// when items are added and removed from the FancyDictionary.  Since the delegate itself has associated types, we must use Type Erasure.

class FakeFancyDictionaryDelegate: FancyDictionaryDelegate {
    var capturedAddedKey: String?
    var capturedAddedValue: Int?
    
    var capturedRemovedKey: String?
    
    func didAdd(key: String, value: Int) {
        capturedAddedKey = key
        capturedAddedValue = value
    }
    
    func didRemove(key: String) {
        capturedRemovedKey = key
    }
}

class FancyDictionarySpec: QuickSpec {
    override func spec() {
        var fakeDelegate: FakeFancyDictionaryDelegate!
        var anyFancyDictionaryDelegate: AnyFancyDictionaryDelegate<String, Int>!
        var subject: FancyDictionary<String, Int>!
        
        beforeEach {
            fakeDelegate = FakeFancyDictionaryDelegate()
            anyFancyDictionaryDelegate = AnyFancyDictionaryDelegate(fakeDelegate)
            
            subject = FancyDictionary<String, Int>()
            subject.delegate = anyFancyDictionaryDelegate
        }
        
        it("has a delegate") {
            expect(subject.delegate).toNot(beNil())
        }

        describe("when a value is added") {
            beforeEach {
                subject["1st-value"] = 1
            }

            it("tells it's delegate that the key/value was added") {
                expect(fakeDelegate.capturedAddedKey).to(equal("1st-value"))
                expect(fakeDelegate.capturedAddedValue).to(equal(1))
            }
            
            describe("when a value is removed") {
                beforeEach {
                    subject["junk"] = 0
                    subject["junk"] = nil
                }
                
                it("tells it's delegate that the key was removed") {
                    expect(fakeDelegate.capturedRemovedKey).to(equal("junk"))
                }
            }
        }
    }
}
