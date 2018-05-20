import Foundation

protocol FrogDelegate: class {
    func frogDidFeed(stomachContents: [Food])
}

enum Food {
    case fly
    case worm
    case moth
}

struct Frog {
    // MARK: - Private Properties
    
    var stomach: [Food] = []
    
    // MARK: Public Properties
    
    weak var delegate: FrogDelegate?
    
    mutating func feed(food: Food) {
        stomach.append(food)
        
        delegate?.frogDidFeed(stomachContents: stomach)
    }
}
