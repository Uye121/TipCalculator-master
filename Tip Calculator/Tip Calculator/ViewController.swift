//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Ulric Ye on 12/2/16.
//  Copyright © 2016 uye. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalPerPerson: UILabel!

    @IBOutlet weak var tipsBar: UISegmentedControl!
    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var peopleInput: UITextField!
    
    var tipPercentages: [Double] = [0.18, 0.20, 0.25]
    var bill: Double?
    var tip: Double?
    var total: Double?
    var perPerson: Double?
    var people: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        peopleInput.text = String(people)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        peopleInput.text = String(people)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        
        bill = Double(userInput.text!) ?? 0
        tip = bill! * (tipPercentages[tipsBar.selectedSegmentIndex])
        total = bill! + tip!
        perPerson = total! / Double(people)
        
        tipLabel.text = String(format: "$%.2f", tip!)
        totalLabel.text = String(format: "$%.2f", total!)
        totalPerPerson.text = String(format: "$%.2f", perPerson!)
    }
    
    @IBAction func changeTip(_ sender: Any) {
        
        bill = Double(userInput.text!) ?? 0
        tip = bill! * (tipPercentages[tipsBar.selectedSegmentIndex])
        total = bill! + tip!
        perPerson = total! / Double(people)
        
        tipLabel.text = String(format: "$%.2f", tip!)
        totalLabel.text = String(format: "$%.2f", total!)
        totalPerPerson.text = String(format: "$%.2f", perPerson!)
    }
    
    @IBAction func changePeople(_ sender: Any) {
        people = Int(peopleInput.text!) ?? 1
        
        // Catch nil errors
        guard let value = total else {
            return
        }
        
        bill = Double(userInput.text!) ?? 0
        tip = bill! * (tipPercentages[tipsBar.selectedSegmentIndex])
        total = bill! + tip!
        perPerson = total! / Double(people)
        
        tipLabel.text = String(format: "$%.2f", tip!)
        totalLabel.text = String(format: "$%.2f", total!)
        totalPerPerson.text = String(format: "$%.2f", perPerson!)
    }

}

