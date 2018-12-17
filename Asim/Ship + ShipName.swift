import Foundation

enum ShipName:Int{
    
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
 //   let id:Int
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
          //    id = 0
            name = .lightFighter
            attack = 50
            shield = 10
            structure = 400
            completeStructure = structure
            completeShield = shield
        case .heavyFighter:
       //       id = 1
            name = .heavyFighter
            attack = 150
            shield = 25
            structure = 1000
            completeStructure = structure
            completeShield = shield
        case .cruiser:
          //    id = 2
            name = .cruiser
            attack = 400
            shield = 50
            structure = 2700
            completeStructure = structure
            completeShield = shield
        case .battleShip:
          //    id = 3
            name = .battleShip
            attack = 1000
            shield = 200
            structure = 6000
            completeStructure = structure
            completeShield = shield
        case .bomber:
          //    id = 4
            name = .bomber
            attack = 1000
            shield = 500
            structure = 7500
            completeStructure = structure
            completeShield = shield
        case .destroyer:
           //   id = 5
            name = .destroyer
            attack = 2000
            shield = 500
            structure = 11000
            completeStructure = structure
            completeShield = shield
            
        case .battleCruiser:
          //    id = 6
            name = .battleCruiser
            attack = 700
            shield = 400
            structure = 7000
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
