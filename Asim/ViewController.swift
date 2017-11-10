import UIKit

class ViewController: UIViewController {
var numberOfSim = 1
    
    
    
    @IBAction func sim(_ sender: Any) {
        let army1Count = 40
        let army2Count = 2000
        var army1 = Array(repeatElement(Ship(.cruiser), count: army1Count))
        var army2 = Array(repeatElement(Ship(.lightFighter), count: army2Count))
        var army1RemainingCount = 0
        var army2RemainingCount = 0
        print("\n\n\n\n\n\n\n\n\n\n")
        for _ in 0..<6{
        
            
            
            let army1Damaged = armyDamaged(attacker: army2, defenser: army1)
            let army2Damaged = armyDamaged(attacker: army1, defenser: army2)
            
            army1 = armyAfterExplosion(armyDamaged: army1Damaged)
            army2 = armyAfterExplosion(armyDamaged: army2Damaged)
            
            print("army1 of \(army1Count) \(army1.first?.name ?? .bomber) has \(army1.count) remaining \(army1.first?.name ?? .bomber)")
            
            /*     for ship in army1{
             guard ship.structure < ship.completeStructure * 70 / 100 else {continue}
             print("\(ship.structure)/\(ship.shield)")
             } */
            print("army2 of \(army2Count) \(army2.first?.name ?? .bomber) has \(army2.count) remaining \(army2.first?.name ?? .bomber)")
            
            /* for ship in army2{
             guard ship.structure < ship.completeStructure * 70 / 100 else {continue}
             print("\(ship.structure)/\(ship.shield)")
             } */
            
            // si un protagoniste a zero, break la loop
            guard army1.count != 0 && army2.count != 0 else{
                army1RemainingCount = army1.count
                army2RemainingCount = army2.count
                break}
            
            // remettre les bouclier à fond
            
            for (index,ship) in army1.enumerated() {
                if ship.shield != ship.completeShield{
                    army1[index].shield = ship.completeShield
                }
            }
            for (index,ship) in army2.enumerated() {
                if ship.shield != ship.completeShield{
                    army2[index].shield = ship.completeShield
                }
            }
            
            for i in 0..<army1.count{
                army1[i].canExplode = false
            }
            for i in 0..<army2.count{
                army2[i].canExplode = false
            }
            
            
            
            
            // fin du round
            
        } // fin du combat
        
    }
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
    } // end of view did load

  
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}

