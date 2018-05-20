import Quick
import Nimble

@testable import SwiftDesignPatterns

// This is a delegate that we can use to verify that messages are being sent to the delegate object

class FakeFrogDelegate: FrogDelegate {
    var capturedStomachContents: [Food]?
    
    func frogDidFeed(stomachContents: [Food]) {
        capturedStomachContents = stomachContents
    }
}

class FrogSpec: QuickSpec {
    override func spec() {
        var fakeDelegate: FakeFrogDelegate!
        var subject: Frog!
        
        beforeEach {
            fakeDelegate = FakeFrogDelegate()
            
            subject = Frog()
            subject.delegate = fakeDelegate
        }
        
        it("has a delegate") {
            expect(subject.delegate).toNot(beNil())
        }
        
        describe("when a frog is fed food") {
            beforeEach {
                subject.feed(food: .fly)
                subject.feed(food: .worm)
                subject.feed(food: .moth)
            }
            
            it("let's it's delegate know that the frog did feed with the current stomach contents") {
                expect(fakeDelegate.capturedStomachContents).to(equal([.fly, .worm, .moth]))
            }
        }
    }
}
