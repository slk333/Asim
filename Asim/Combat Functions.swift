import Foundation
func randomInteger(cap:Int)->Int{
    
    return Int(arc4random_uniform(UInt32(cap)))
}
func rand()->Float{
    return Float(arc4random_uniform(UInt32.max))/Float(UInt32.max)
    
}

func armyAfterExplosion(armyDamaged:[Ship])->[Ship]{
    // removing destroyed ship
    let armyAfterDestruction = armyDamaged.filter{$0.structure != 0}
    
    let armyAfterExplosion = armyAfterDestruction.filter{ship in
        // keep ship that has not been attacked
        if ship.canExplode == false {return true}
        // keep ship over 70%
        if ship.structure == ship.completeStructure{
            return true
        }
        let shipStructureCoeff = Float(ship.structure)/Float(ship.completeStructure)
        if shipStructureCoeff > 0.70{
            return true
        }
            // if ship is equal to or under 70% of completeStructure,
            // return true only if shipStructure is above the rand
        else {
            return shipStructureCoeff > rand()
            
        }
        
    }
    
    return armyAfterExplosion
}

func armyDamaged(attacker:[Ship],defenser:[Ship])->[Ship]{
    var defenserFighting=defenser
    var attackerFighting=attacker
    var shouldShotAgainShips=[Ship]()
    shouldShotAgainShips.reserveCapacity(attacker.count)
    
    // tant que l'attacker a encore des vaisseaux à faire tirer, faire tirer les vaisseaux, si tous les vaisseaux de rf ont tirés, attackerFighting sera vide
    while !attackerFighting.isEmpty{
    for attackingShip in attackerFighting{
        // choisir un vaisseau au hasard
        let i = randomInteger(cap: defenser.count)
        let shipAttacked = defenserFighting[i]
        
        // si la structure est nulle, passez au vaisseau attaquant suivant
        guard shipAttacked.structure != 0 else {continue}
        
        // si l'attaquant one shot le vaisseau, mettre structure à zero et passer au suivant
        guard attackingShip.attack < shipAttacked.structure + shipAttacked.shield else{
            defenserFighting[i].structure = 0
            defenserFighting[i].shield = 0
            defenserFighting[i].canExplode = true
            continue
        }
        // si le bouclier est nul, infliger directement le dégat à la structure et mettre à zéro si négatif puis passer au suivant
        guard shipAttacked.shield != 0 else {
            defenserFighting[i].structure -= attackingShip.attack
            defenserFighting[i].canExplode = true
            if defenserFighting[i].structure < 0 {defenserFighting[i].structure = 0}
            continue
        }
        
        // à ce point, le bouclier et la structure sont présents
        let remainingAttack = attackingShip.attack - shipAttacked.shield
        // si lattaque est plus forte que le boubou, infliger ce qu'il reste de l'attaque
        if remainingAttack >= 0{
            defenserFighting[i].shield = 0
            defenserFighting[i].structure -= remainingAttack
            defenserFighting[i].canExplode = true
            if defenserFighting[i].structure < 0 {defenserFighting[i].structure = 0}
        }
            // sinon, infliger l'attaque seulement au boubou
        else{
            defenserFighting[i].shield -= attackingShip.attack
        }// l'attacking ship a infligé les dégats au defending ship
        
        // vérifier si le vaisseau peut tirer à nouveau : RAPID FIRE
        guard let rf = attackingShip.rapidFireAgainst(ship: shipAttacked) else {continue}
        // vérifier si le vaisseau va tirer à nouveau
        // cas où il n'a pas de chance
        if 1.0/Float(rf) > rand(){continue}
        // cas où il peut tirer à nouveau
        else{
            shouldShotAgainShips.append(attackingShip)
        }
        
    } // fin de l'attaque de l'armée, le RF n'a pas encoré été effectué
    // dans le cadre du round qui n'est pas fini, on remplace l'armée attaquante par les vaisseaux qui doivent tirer à nouveau, tant qu'il reste des vaisseau qui doivent tirer
    attackerFighting = shouldShotAgainShips
    shouldShotAgainShips = []
    
} // fin de l'attaque de l'armée, le RF a été effectué
    return defenserFighting
}
