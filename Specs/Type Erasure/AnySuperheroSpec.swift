import Quick
import Nimble

@testable import SwiftDesignPatterns

class AnySuperheroSpec: QuickSpec {
    override func spec() {
        var captainAmerica: CaptainAmerica!
        var subject: AnySuperHero<SuperSoldier>!
        
        beforeEach {
            captainAmerica = CaptainAmerica()
            
            subject = AnySuperHero(captainAmerica)
        }
        
        it("allows you to use objects that conform to 'Superhero' be used as a type") {
            let superheroArray: [AnySuperHero<SuperSoldier>] = [subject]
            
            expect(superheroArray.first!.superPower).to(beAnInstanceOf(SuperSoldier.self))
            
            // Note: Here are some additional examples
            
            let spiderMen = [AnySuperHero(Silk()), AnySuperHero(SpiderMan())]
            
            expect(spiderMen[0].superPower).to(beAnInstanceOf(PowersOfSpider.self))
            expect(spiderMen[1].superPower).to(beAnInstanceOf(PowersOfSpider.self))
            
            // If you use AnySuperHero in a collection, they still have to have the same associated type (homogenous)
            // or you get a compile error.  For example, as much as MrWDW would love to work with Thor, you can't do this:
            
            // let superTeam = [AnySuperHero(MrWDW()), AnySuperHero(Thor())]
        }
    }
}

