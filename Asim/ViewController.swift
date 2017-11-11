import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var aLF:UITextField!
    @IBOutlet weak var aHF:UITextField!
    @IBOutlet weak var aCR:UITextField!
    @IBOutlet weak var aBS:UITextField!
    @IBOutlet weak var aBC:UITextField!
    @IBOutlet weak var aBB:UITextField!
    @IBOutlet weak var aDE:UITextField!
    
    @IBOutlet weak var dLF:UITextField!
    @IBOutlet weak var dHF:UITextField!
    @IBOutlet weak var dCR:UITextField!
    @IBOutlet weak var dBS:UITextField!
    @IBOutlet weak var dBC:UITextField!
    @IBOutlet weak var dBB:UITextField!
    @IBOutlet weak var dDE:UITextField!
    
    @IBOutlet weak var aLFLabel:UILabel!
    @IBOutlet weak var aHFLabel:UILabel!
    @IBOutlet weak var aCRLabel:UILabel!
    @IBOutlet weak var aBSLabel:UILabel!
    @IBOutlet weak var aBCLabel:UILabel!
    @IBOutlet weak var aBBLabel:UILabel!
    @IBOutlet weak var aDELabel:UILabel!
    
    @IBOutlet weak var dLFLabel:UILabel!
    @IBOutlet weak var dHFLabel:UILabel!
    @IBOutlet weak var dCRLabel:UILabel!
    @IBOutlet weak var dBSLabel:UILabel!
    @IBOutlet weak var dBCLabel:UILabel!
    @IBOutlet weak var dBBLabel:UILabel!
    @IBOutlet weak var dDELabel:UILabel!
    
    @IBAction func sim(_ sender: Any) {
        let startDate=Date()
        
        
        var army1 = [Ship]()
        var army2 = [Ship]()
        
      
        army1.append(contentsOf:Array(repeatElement(Ship(.lightFighter), count: Int(aLF.text ?? String(0)) ?? 0)))
        army1.append(contentsOf:Array(repeatElement(Ship(.heavyFighter), count: Int(aHF.text ?? String(0)) ?? 0)))
        army1.append(contentsOf:Array(repeatElement(Ship(.cruiser), count: Int(aCR.text ?? String(0)) ?? 0)))
        army1.append(contentsOf:Array(repeatElement(Ship(.battleShip), count: Int(aBS.text ?? String(0)) ?? 0)))
        army1.append(contentsOf:Array(repeatElement(Ship(.battleCruiser), count: Int(aBC.text ?? String(0)) ?? 0)))
        army1.append(contentsOf:Array(repeatElement(Ship(.bomber), count: Int(aBB.text ?? String(0)) ?? 0)))
        army1.append(contentsOf:Array(repeatElement(Ship(.destroyer), count: Int(aDE.text ?? String(0)) ?? 0)))
        
        
        army2.append(contentsOf:Array(repeatElement(Ship(.lightFighter), count: Int(dLF.text ?? String(0)) ?? 0)))
        army2.append(contentsOf:Array(repeatElement(Ship(.heavyFighter), count: Int(dHF.text ?? String(0)) ?? 0)))
        army2.append(contentsOf:Array(repeatElement(Ship(.cruiser), count: Int(dCR.text ?? String(0)) ?? 0)))
        army2.append(contentsOf:Array(repeatElement(Ship(.battleShip), count: Int(dBS.text ?? String(0)) ?? 0)))
        army2.append(contentsOf:Array(repeatElement(Ship(.battleCruiser), count: Int(dBC.text ?? String(0)) ?? 0)))
        army2.append(contentsOf:Array(repeatElement(Ship(.bomber), count: Int(dBB.text ?? String(0)) ?? 0)))
        army2.append(contentsOf:Array(repeatElement(Ship(.destroyer), count: Int(dDE.text ?? String(0)) ?? 0)))
        
        let (army1AfterSim,army2AfterSim) = Asim.sim(army1: army1, army2: army2)
        print("\n")
        aLFLabel.text = String(army1AfterSim.lf)
        aHFLabel.text = String(army1AfterSim.hf)
        aCRLabel.text = String(army1AfterSim.cr)
        aBSLabel.text = String(army1AfterSim.bs)
        aBCLabel.text = String(army1AfterSim.bc)
        aBBLabel.text = String(army1AfterSim.bb)
        aDELabel.text = String(army1AfterSim.de)
        
        dLFLabel.text = String(army2AfterSim.lf)
        dHFLabel.text = String(army2AfterSim.hf)
        dCRLabel.text = String(army2AfterSim.cr)
        dBSLabel.text = String(army2AfterSim.bs)
        dBCLabel.text = String(army2AfterSim.bc)
        dBBLabel.text = String(army2AfterSim.bb)
        dDELabel.text = String(army2AfterSim.de)
        
        
        
        
        
        print("\(army1AfterSim.lf) lf")
        print("\(army1AfterSim.hf) hf")
        print("\(army1AfterSim.cr) cr")
        print("\(army1AfterSim.bs) bs")
        print("\(army1AfterSim.bc) bc")
        print("\(army1AfterSim.bb) bb")
        print("\(army1AfterSim.de) de")
        print("\n")
        print("\n")
        print("\(army2AfterSim.lf) lf")
        print("\(army2AfterSim.hf) hf")
        print("\(army2AfterSim.cr) cr")
        print("\(army2AfterSim.bs) bs")
        print("\(army2AfterSim.bc) bc")
        print("\(army2AfterSim.bb) bb")
        print("\(army2AfterSim.de) de")
        print("\n")
        
        
        // log les détails de chaque armée après sim
        
   /*     print("\(army1AfterSim.filter{$0.name == .lightFighter}.count) \(ShipName.lightFighter.rawValue)")
        print("\(army1AfterSim.filter{$0.name == .heavyFighter}.count) \(ShipName.heavyFighter.rawValue)")
        print("\(army1AfterSim.filter{$0.name == .cruiser}.count) \(ShipName.cruiser.rawValue)")
        print("\(army1AfterSim.filter{$0.name == .battleShip}.count) \(ShipName.battleShip.rawValue)")
        print("\(army1AfterSim.filter{$0.name == .battleCruiser}.count) \(ShipName.battleCruiser.rawValue)")
        print("\(army1AfterSim.filter{$0.name == .bomber}.count) \(ShipName.bomber.rawValue)")
        print("\(army1AfterSim.filter{$0.name == .destroyer}.count) \(ShipName.destroyer.rawValue)")
        
        print("\(army2AfterSim.filter{$0.name == .lightFighter}.count) \(ShipName.lightFighter.rawValue)")
        print("\(army2AfterSim.filter{$0.name == .heavyFighter}.count) \(ShipName.heavyFighter.rawValue)")
        print("\(army2AfterSim.filter{$0.name == .cruiser}.count) \(ShipName.cruiser.rawValue)")
        print("\(army2AfterSim.filter{$0.name == .battleShip}.count) \(ShipName.battleShip.rawValue)")
        print("\(army2AfterSim.filter{$0.name == .battleCruiser}.count) \(ShipName.battleCruiser.rawValue)")
        print("\(army2AfterSim.filter{$0.name == .bomber}.count) \(ShipName.bomber.rawValue)")
        print("\(army2AfterSim.filter{$0.name == .destroyer}.count) \(ShipName.destroyer.rawValue)")
        */
        
        let endDate=Date()
        let interval = endDate.timeIntervalSince(startDate)
        print(interval)
        
    } // fin de l'action du bouton
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    } // end of view did load
    
}

