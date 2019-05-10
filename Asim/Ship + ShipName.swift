import Foundation



protocol Ship {
    static var attack:Int {get}
    static var completeShield:Int {get}
    static var completeStructure:Int {get}
    static var name:ShipName {get}
    
    var shield : Int {get set}
    var structure : Int {get set}
    var willExplode : Bool {get set}
    
    static func rapidFireAgainst(shipType:Ship.Type)->Int?

}


enum ShipName:Int{
    
    case lightFighter
    case heavyFighter
    case battleShip
    case cruiser
    case battleCruiser
    case bomber
    case destroyer
}

struct LightFighter : Ship {
    
    static let attack = 50
    static let completeShield = 10
    static let completeStructure = 400
    static let name = ShipName.lightFighter
    
    var shield = 10
    var structure = 400
    var willExplode = false
    
    static func rapidFireAgainst(shipType:Ship.Type)->Int?{
        // check du vaissau attaquant
        return nil
    }
    init(){
        
    }
}

struct HeavyFighter : Ship {
    
    static let attack = 150
    static let completeShield = 25
    static let completeStructure = 1000
    static let name = ShipName.heavyFighter
    
    var shield = 25
    var structure = 1000
    var willExplode = false
    
    static func rapidFireAgainst(shipType:Ship.Type)->Int?{
        // check du vaissau attaquant
        return nil
    }
    init(){
        
    }
}

struct Cruiser : Ship {
    
    
    
    static let attack = 400
    static let completeShield = 50
    static let completeStructure = 2700
    static let name = ShipName.cruiser
    
    var shield = 50
    var structure = 2700
    var willExplode = false
    
    static func rapidFireAgainst(shipType:Ship.Type)->Int?{
        // check du vaissau attaquant
        if shipType.name == .lightFighter{return 6}
        return nil
    }
    init(){
        
    }
}

struct BattleShip : Ship {
    
    static let attack = 1000
    static let completeShield = 200
    static let completeStructure = 6000
    static let name = ShipName.battleShip
    
    var shield = 200
    var structure = 6000
    var willExplode = false
    static func rapidFireAgainst(shipType:Ship.Type)->Int?{
        // check du vaissau attaquant
        return nil
    }
    init(){
        
    }
}

struct Bomber : Ship {
    
    static let attack = 1000
    static let completeShield = 500
    static let completeStructure = 7500
    static let name = ShipName.bomber
    
    var shield = 500
    var structure = 7500
    var willExplode = false
    static func rapidFireAgainst(shipType:Ship.Type)->Int?{
        // check du vaissau attaquant
        return nil
    }
    init(){
        
    }
}

struct Destroyer : Ship {
    
    static let attack = 2000
    static let completeShield = 500
    static let completeStructure = 11000
    static let name = ShipName.destroyer
    
    var shield = 500
    var structure = 11000
    var willExplode = false
    
    static func rapidFireAgainst(shipType:Ship.Type)->Int?{
        // check du vaissau attaquant
        if shipType.name == .battleCruiser{return 2}
        return nil
    }
    init(){
        
    }
    
}

struct BattleCruiser : Ship {
    
    static let attack = 700
    static let completeShield = 400
    static let completeStructure = 7000
    static let name = ShipName.battleCruiser
    
    var shield = 400
    var structure = 7000
    var willExplode = false
    static func rapidFireAgainst(shipType:Ship.Type)->Int?{
        // check du vaissau attaquant
        if shipType.name == .battleShip{return 7}
        if shipType.name == .cruiser{return 4}
        if shipType.name == .heavyFighter{return 3}
        return nil
    }
    init(){
        
    }
}


/*
struct Ship111{
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
*/
