import Foundation

enum ShipName:String{
    
    case lightFighter
    case heavyFighter
    case battleShip
    case cruiser
    case battleCruiser
    case bomber
    case destroyer
}

struct Ship{
    let name:ShipName
    let attack:Int
    var shield:Int
    var structure:Int
    var willExplode:Bool
    let completeShield:Int!
    let completeStructure:Int!
    
    init(_ shipName:ShipName){
        willExplode = false
        switch shipName{
        case .lightFighter:
            name = .lightFighter
            attack = 50
            shield = 10
            structure = 400
            completeStructure = structure
            completeShield = shield
        case .battleShip:
            name = .battleShip
            attack = 1000
            shield = 200
            structure = 6000
            completeStructure = structure
            completeShield = shield
        case .cruiser:
            name = .cruiser
            attack = 400
            shield = 50
            structure = 2700
            completeStructure = structure
            completeShield = shield
        case .heavyFighter:
            name = .heavyFighter
            attack = 150
            shield = 25
            structure = 1000
            completeStructure = structure
            completeShield = shield
        case .battleCruiser:
            name = .battleCruiser
            attack = 700
            shield = 400
            structure = 7000
            completeStructure = structure
            completeShield = shield
        case .bomber:
            name = .bomber
            attack = 1000
            shield = 500
            structure = 7500
            completeStructure = structure
            completeShield = shield
            
        case .destroyer:
            name = .destroyer
            attack = 2000
            shield = 500
            structure = 11000
            completeStructure = structure
            completeShield = shield
        }
        
    } // fin de init
  
    func rapidFireAgainst(ship:Ship)->Int?{
        // check du vaissau attaquant
        switch self.name{
        case .lightFighter,.heavyFighter,.bomber,.battleShip:
            return nil
        case .cruiser:
            if ship.name == .lightFighter{return 6}
            return nil
        case .destroyer:
            if ship.name == .battleCruiser{return 2}
            return nil
        case .battleCruiser:
            if ship.name == .battleShip{return 7}
            if ship.name == .cruiser{return 4}
            if ship.name == .heavyFighter{return 3}
            return nil
        }
        

    
    }
    
    
    
    
}
