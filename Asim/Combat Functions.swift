import Foundation


let mySerialQueue = DispatchQueue(label: "mySerialQueue")


func sim(numberOfSim:Int=1,army1Argument:[Ship],army2Argument:[Ship],completion:@escaping((lf: Int, hf: Int, cr: Int, bs: Int, bc: Int, bb: Int, de: Int),(lf: Int, hf: Int, cr: Int, bs: Int, bc: Int, bb: Int, de: Int))->())->(){
    
    var army1Result=[Int]()
    var army2Result=[Int]()
    var army1DictionaryResult:[ShipName:Int]=[.lightFighter:0,.heavyFighter:0,.cruiser:0,.battleShip:0,.battleCruiser:0,.bomber:0,.destroyer:0]
    var army2DictionaryResult:[ShipName:Int]=[.lightFighter:0,.heavyFighter:0,.cruiser:0,.battleShip:0,.battleCruiser:0,.bomber:0,.destroyer:0]
    
    let shipOrder:[ShipName]=[.lightFighter,.heavyFighter,.cruiser,.battleShip,.battleCruiser,.bomber,.destroyer]
    
    
    
    
    
    //  let army1Count = army1.count
    //  let army2Count = army2.count
    let dispatchGroup = DispatchGroup()
    
    simulations: for i in 0..<numberOfSim{
        // début de la simulation, on reinitialise les deux armées
        
        dispatchGroup.enter()
        DispatchQueue.global().async {
            
            
            var army1 = army1Argument
            var army2 = army2Argument
            
            combat: for round in 0..<6{
                print("round: \(round)")
                
                attackerShoots(attacker: army1, defenser: &army2)
                attackerShoots(attacker: army2, defenser: &army1)
                
                
                army1 = army1.filter{$0.willExplode == false}
                army2 = army2.filter{$0.willExplode == false}
                
                // si une armée est détruite, terminer la loop de combat
                if army1.isEmpty || army2.isEmpty {break combat}
                
                // remettre les bouclier à fond
                for (index,ship) in army1.enumerated() {army1[index].shield = ship.completeShield}
                for (index,ship) in army2.enumerated() {army2[index].shield = ship.completeShield}
                
                // fin du round
                
            }// fin du combat n
            
            // log le résultat du combat
            //  print("army1 of \(army1Count) \(army1.first?.name ?? .bomber) has \(army1.count) remaining \(army1.first?.name ?? .bomber)")
            //    print("army2 of \(army2Count) \(army2.first?.name ?? .bomber) has \(army2.count) remaining \(army2.first?.name ?? .bomber)")
            
            mySerialQueue.async {
                
                
                print(i)
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
                dispatchGroup.leave()
                
                
            } // fin de l'opération à executer séquentiellement
           
            
            
        } // fin du du dispatch d'un combat
        
        
        
    } // fin du dispatch des combats
    
    
    // fonction qui calcule le nombre moyen de vaisseau à partir du résultat de toutes les simulation
    func resultAsTuple(dictionary:[ShipName:Int])->(lf:Int,hf:Int,cr:Int,bs:Int,bc:Int,bb:Int,de:Int){
        let avgDict = dictionary.mapValues{$0/numberOfSim}
        return (avgDict[.lightFighter]!,avgDict[.heavyFighter]!,avgDict[.cruiser]!,avgDict[.battleShip]!,avgDict[.battleCruiser]!,avgDict[.bomber]!,avgDict[.destroyer]!)
    }
    
    
    
    
    
    dispatchGroup.notify(queue: .main){
        completion(resultAsTuple(dictionary:army1DictionaryResult),resultAsTuple(dictionary:army2DictionaryResult))
        print("\n")
        print(army1Result)
        print(army2Result)
    }
    
    
    
    
    // return les armées en fin de sim
    return
}



// l'armée tire sur l'autre, la fonction return l'armée du défenseur, dont les vaisseaux sont marqués avec willExplode ou non

func attackerShoots(attacker:[Ship], defenser:inout [Ship]){
    let defenserCount = defenser.count
    
    var rf:Int?
   

        for attackingShip in attacker{
      //      print("\(attackingShip.name) now attacking")
           
          
        // choisir un vaisseau au hasard
        individualShipAttack: repeat{
            
            let i = Int.random(in: 0..<defenserCount)
         //   print("cible le \(defenser[i].name) numéro \(i)")
            
            rf = attackingShip.rapidFireAgainst(ship: defenser[i]) ?? 1
            // si l'attaquant n'a pas de rapidfire, mettre fin à l'attaque individuelle du vaisseau
            
            
            // si le défenseur est déjà programmé pour exploser, inutile d'appliquer des dégats sur le vaisseau, passez au vaisseau attaquant suivant
            guard defenser[i].willExplode == false else {
         //       print("le défenseur selectionné a deja explosé ")
                continue individualShipAttack}
            
            // si l'attaquant one shot le vaisseau, programmer son explosion, et passer au vaisseau attaquant suivant
            
        /*    guard attackingShip.attack < shipAttacked.structure + shipAttacked.shield else{
                defenserFighting[i].willExplode = true
                continue attacking
            } */
            
            // si l'attaquant ne oneshot pas, infliger dégats, et roll explosion si coque inférieure à 70%
            
            let remainingAttackForStructure = attackingShip.attack - defenser[i].shield
       //     print("\(remainingAttackForStructure) dégats vont s'appliquer sur la coque")
            
            // si l'attaquant n'inflige que des dégats au bouclier (celà ne l'empêchera pas d'exploser si il est déja endommagé)
            if remainingAttackForStructure <= 0 {
                // diminuer le bouclier
                defenser[i].shield -= attackingShip.attack
        //    print("la coque est intacte et le bouclier du défendeur vaut désormais \(defenser[i].shield)")
            }
                
                // sinon, entamer sa coque directement
            else{ //l'attaquant surpasse le bouclier et inflige les dégats restant à la structure
                
                defenser[i].shield = 0
          //       print("le bouclier du défendeur vaut désormais \(defenser[i].shield)")
                defenser[i].structure -= remainingAttackForStructure
          //      print("la structure du défendeur vaut désormais \(defenser[i].structure)")
            }
            
            // comme le vaisseau ennemi a été visé par un tir, il peut exploser si sa coque est inférieure ou égale à 70
            
           
           // print("\(shipAttacked.name) has \(shipStructureCoeff) % integrity")
           
            // le vaisseau n'est pas vulnérable
            
       /*     print("""
                la structure est \(defenser[i].structure) comparé à l'original de \(defenser[i].completeStructure!). Le seuil est à \(Int(Float(defenser[i].completeStructure) * 0.70))
                """)
 */
            if defenser[i].structure <= Int(Float(defenser[i].completeStructure) * 0.70){
                // il explosera si il n'arrive pas à dépasser le rand
                // ce qui arrivera souvent si son coeff est faible
             //   print("le vaisseau est en zone de danger")
                defenser[i].willExplode = defenser[i].completeStructure - defenser[i].structure > Int.random(in: 0..<defenser[i].completeStructure)
                // il faut que le ship puisse survivre si il est à 1%. 1 n'est pas inférieur à 1, mais inférieur au dela
             //   print("le vaisseau va exploser : \(defenser[i].willExplode)")
            }
            
            
            
          
            
        } // fin du repeat
            // l'attaquant possède un rapid fire
            // roll RAPID FIRE
            // le vaisseau continue d'attaquer tant que le rapid fire roll vrai
            while Int.random(in: 0..<rf!) < rf!-1
            // si le rf vaut 1, il faut un nombre plus grand que 100, ce qui ne doit pas être possible
            // si le rf vaut 2, il faut un nombre plus grand que 50 , 6 7 8 9 10. Tandis que 5 4 3 2 1 ne sont pas suffisants
            // si le rf vaut 200, il faut un nombre plus grand que 100/200, c'est à dire plus grand que 0, or ce sera toujours le cas.
            // il faut que le roll le plus petit fasse zéro
            
        
        // fin de la boucle repeat qui matérialise l'attaque individuelle du vaisseau
        // on passe au vaisseau individuel suivant
    } // fin de l'attaque de l'armée pour le round
    return
}
