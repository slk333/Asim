import Foundation
func randomInteger(cap:Int)->Int{
    
     return Int(arc4random()) % cap
}

func rand2()->Int{
    return Int(arc4random_uniform(UInt32.max) % 100)
}




func sim(numberOfSim:Int=20,army1:[Ship],army2:[Ship])->((lf:Int,hf:Int,cr:Int,bs:Int,bc:Int,bb:Int,de:Int),(lf:Int,hf:Int,cr:Int,bs:Int,bc:Int,bb:Int,de:Int)){
    
    var army1Result=[Int]()
    var army2Result=[Int]()
  
    
    var army1DictionaryResult:[ShipName:Int]=[.lightFighter:0,.heavyFighter:0,.cruiser:0,.battleShip:0,.battleCruiser:0,.bomber:0,.destroyer:0]
    var army2DictionaryResult:[ShipName:Int]=[.lightFighter:0,.heavyFighter:0,.cruiser:0,.battleShip:0,.battleCruiser:0,.bomber:0,.destroyer:0]
    
    let shipOrder:[ShipName]=[.lightFighter,.heavyFighter,.cruiser,.battleShip,.battleCruiser,.bomber,.destroyer]
    
 
    
    
    
    let army1Count = army1.count
    let army2Count = army2.count
    
    simulations: for _ in 0..<numberOfSim{
        // début de la simulation, on reinitialise les deux armées
        var army1 = army1
        var army2 = army2
    
    combat: for _ in 0..<6{
        
        army1 = armyDamaged(attacker: army2, defenser: army1)
        army2 = armyDamaged(attacker: army1, defenser: army2)
        
        army1 = army1.filter{$0.willExplode == false}
        army2 = army2.filter{$0.willExplode == false}
        
        // si une armée est détruite, terminer la loop de combat
        guard army1.count != 0 && army2.count != 0 else{break combat}
        
        // remettre les bouclier à fond
        for (index,ship) in army1.enumerated() {army1[index].shield = ship.completeShield}
        for (index,ship) in army2.enumerated() {army2[index].shield = ship.completeShield}
        
        // fin du round
        
    } // fin du combat n
        // log le résultat du combat
    print("army1 of \(army1Count) \(army1.first?.name ?? .bomber) has \(army1.count) remaining \(army1.first?.name ?? .bomber)")
    print("army2 of \(army2Count) \(army2.first?.name ?? .bomber) has \(army2.count) remaining \(army2.first?.name ?? .bomber)")
        print("\n")
        // enregistrer le résultat du combat n
        army1Result.append(army1.count)
        army2Result.append(army2.count)
     
        for shipName in shipOrder{
            let numberOfShip = army1.prefix{$0.name == shipName}.count
             army1DictionaryResult[shipName]! += numberOfShip
            army1.removeSubrange(0..<numberOfShip)
        }
        for shipName in shipOrder{
            let numberOfShip = army2.prefix{$0.name == shipName}.count
            army2DictionaryResult[shipName]! += numberOfShip
            army2.removeSubrange(0..<numberOfShip)
        }
        
       
        
        
        
        
    } // fin des simulations
    // fonction qui calcule le nombre moyen de vaisseau à partir du résultat de toutes les simulation
    func resultAsTuple(dictionary:[ShipName:Int])->(lf:Int,hf:Int,cr:Int,bs:Int,bc:Int,bb:Int,de:Int){
        let avgDict = dictionary.mapValues{$0/numberOfSim}
    return (avgDict[.lightFighter]!,avgDict[.heavyFighter]!,avgDict[.cruiser]!,avgDict[.battleShip]!,avgDict[.battleCruiser]!,avgDict[.bomber]!,avgDict[.destroyer]!)
    }
    
    
    
    print("\n")
    print(army1Result)
    print(army2Result)
  
 
    // return les armées en fin de sim
    return (resultAsTuple(dictionary:army1DictionaryResult),resultAsTuple(dictionary:army2DictionaryResult))
}



// l'armée tire sur l'autre, la fonction return l'armée du défenseur, dont les vaisseaux sont marqués avec willExplode ou non

func armyDamaged(attacker:[Ship],defenser:[Ship])->[Ship]{
    var defenserFighting=defenser
    var attackerFighting=attacker
    var shouldShotAgainShips=[Ship]()
   // shouldShotAgainShips.reserveCapacity(attacker.count)
    
    // tant que l'attacker a encore des vaisseaux à faire tirer, faire tirer les vaisseaux, si tous les vaisseaux de rf ont tirés, attackerFighting sera vide
    rf: while !attackerFighting.isEmpty{
        attacking: for attackingShip in attackerFighting{
            // choisir un vaisseau au hasard
            let i = randomInteger(cap: defenser.count)
            var shipAttacked = defenserFighting[i]
            
            
            // roll RAPID FIRE et mettre en file d'attente si RF activé. Le vaisseau attaquera à nouveau lorsque tous les vaisseaux attaquant auront fini d'attaquer.
            if let rf = attackingShip.rapidFireAgainst(ship: shipAttacked){
                // le vaisseau tirera à nouveau
                if 10000/(rf*100) <= rand2(){
                    shouldShotAgainShips.append(attackingShip)
                }
            }
            
            
            // si le défenseur est déjà programmé pour exploser, passez au vaisseau attaquant suivant
            guard shipAttacked.willExplode != true else {continue attacking}
            
            // si l'attaquant one shot le vaisseau, programmer son explosion, et passer au vaisseau attaquant suivant
            
            guard attackingShip.attack < shipAttacked.structure + shipAttacked.shield else{
                defenserFighting[i].willExplode = true
                continue attacking
            }
            
            
        
            // si l'attaquant ne oneshot pas, infliger dégats, roll explosion le cas échéant, et passer au vaisseau suivant
            
            let remainingAttackForStructure = attackingShip.attack - shipAttacked.shield
            // si l'attaquant n'inflige que des dégats au bouclier
            guard remainingAttackForStructure > 0 else{defenserFighting[i].shield -= attackingShip.attack
                continue attacking
            }
            
            //l'attaquant surpasse le bouclier et inflige des dégats à la structure
                shipAttacked.shield = 0
                shipAttacked.structure -= remainingAttackForStructure
                let shipStructureCoeff = (shipAttacked.structure*100)/(shipAttacked.completeStructure)
                defenserFighting[i] = shipAttacked
            // le vaisseau n'est pas vulnérable
            if shipStructureCoeff > 70 {
                continue attacking
            }
            // le vaisseau est vulnérable
            else{
                // il explosera si il n'arrive pas à dépasser le rand
                // ce qui arrivera souvent si son coeff est faible
                defenserFighting[i].willExplode = shipStructureCoeff < rand2()
                
            }
            
            
           
            
            
        } // fin de l'attaque de l'armée, le RF n'a pas encoré été effectué
        // dans le cadre du round qui n'est pas fini, on remplace l'armée attaquante par les vaisseaux qui doivent tirer à nouveau, tant qu'il reste des vaisseau qui doivent tirer
        if shouldShotAgainShips.isEmpty{
            
            break rf
        }
        attackerFighting = shouldShotAgainShips
        
        shouldShotAgainShips = []
        
    } // fin de l'attaque de l'armée, le RF a été effectué
    return defenserFighting
}
