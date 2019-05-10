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
        
      
        
        let count1 = Int(self.aLF.text ?? String(0))!
        
        army1.append(contentsOf: Array(repeatElement(LightFighter(), count: count1)))
        
        
        /*
            army1.append(contentsOf:Array(repeatElement(Ship(.heavyFighter), count: Int(self.aHF.text ?? String(0)) ?? 0)))
            army1.append(contentsOf:Array(repeatElement(Ship(.cruiser), count: Int(self.aCR.text ?? String(0)) ?? 0)))
            army1.append(contentsOf:Array(repeatElement(Ship(.battleShip), count: Int(self.aBS.text ?? String(0)) ?? 0)))
            army1.append(contentsOf:Array(repeatElement(Ship(.battleCruiser), count: Int(self.aBC.text ?? String(0)) ?? 0)))
            army1.append(contentsOf:Array(repeatElement(Ship(.bomber), count: Int(self.aBB.text ?? String(0)) ?? 0)))
            army1.append(contentsOf:Array(repeatElement(Ship(.destroyer), count: Int(self.aDE.text ?? String(0)) ?? 0)))
 */
        
        
        army2.append(contentsOf: Array(repeatElement(Cruiser(), count: Int(self.dCR.text ?? String(0)) ?? 0)))
      
        /*
        
            army2.append(contentsOf:Array(repeatElement(Ship(.lightFighter), count: Int(self.dLF.text ?? String(0)) ?? 0)))
            army2.append(contentsOf:Array(repeatElement(Ship(.heavyFighter), count: Int(self.dHF.text ?? String(0)) ?? 0)))
            army2.append(contentsOf:Array(repeatElement(Ship(.cruiser), count: Int(self.dCR.text ?? String(0)) ?? 0)))
            army2.append(contentsOf:Array(repeatElement(Ship(.battleShip), count: Int(self.dBS.text ?? String(0)) ?? 0)))
            army2.append(contentsOf:Array(repeatElement(Ship(.battleCruiser), count: Int(self.dBC.text ?? String(0)) ?? 0)))
            army2.append(contentsOf:Array(repeatElement(Ship(.bomber), count: Int(self.dBB.text ?? String(0)) ?? 0)))
            army2.append(contentsOf:Array(repeatElement(Ship(.destroyer), count: Int(self.dDE.text ?? String(0)) ?? 0)))
 */
        
        DispatchQueue.global().async {
            Asim.sim(army1Argument: army1, army2Argument: army2){
                (army1AfterSim,army2AfterSim) in
                
                print("I got there and i have all i need")
                print(army1AfterSim)
                print(army2AfterSim)
               
                
                
                DispatchQueue.main.async {
                    self.aLFLabel.text = String(army1AfterSim.lf)
                    self.aHFLabel.text = String(army1AfterSim.hf)
                    self.aCRLabel.text = String(army1AfterSim.cr)
                    self.aBSLabel.text = String(army1AfterSim.bs)
                    self.aBCLabel.text = String(army1AfterSim.bc)
                    self.aBBLabel.text = String(army1AfterSim.bb)
                    self.aDELabel.text = String(army1AfterSim.de)
                    self.dLFLabel.text = String(army2AfterSim.lf)
                    self.dHFLabel.text = String(army2AfterSim.hf)
                    self.dCRLabel.text = String(army2AfterSim.cr)
                    self.dBSLabel.text = String(army2AfterSim.bs)
                    self.dBCLabel.text = String(army2AfterSim.bc)
                    self.dBBLabel.text = String(army2AfterSim.bb)
                    self.dDELabel.text = String(army2AfterSim.de)
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
                    
                    
                  
                    
                    let endDate=Date()
                    let interval = endDate.timeIntervalSince(startDate)
                    print(interval)
                } // fin de l'action à executer sur le main thread
                
                
                
            } // fin du completion handler
            
           
            
     
     
            
            
            
            
            
        } // fin de l'action distribué async
        
        print("\n")
        print("la fonction a return mais les simulations sont encore en cours")
        
        
    } // fin de l'action du bouton
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    } // end of view did load
    
}

