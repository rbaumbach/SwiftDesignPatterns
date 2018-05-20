import Foundation

class AnySuperHero<SuperPower>: Superhero {
    private let box: AnySuperHeroBase<SuperPower>
    
    init<T: Superhero>(_ concrete: T) where T.SuperPower == SuperPower {
        box = AnySuperHeroBox(concrete)
    }
    
    var superPower: SuperPower {
        get { return box.superPower }
        set { box.superPower = superPower }
    }
}

// MARK: - Private Classes

private class AnySuperHeroBase<SuperPower>: Superhero {
    var superPower: SuperPower {
        get { fatalError("Must override") }
        set { fatalError("Must override") }
    }
}

private class AnySuperHeroBox<T: Superhero>: AnySuperHeroBase<T.SuperPower> {
    var concrete: T
    
    init(_ concrete: T) {
        self.concrete = concrete
    }
    
    override var superPower: T.SuperPower {
        get { return concrete.superPower }
        set { concrete.superPower = superPower}
    }
}
