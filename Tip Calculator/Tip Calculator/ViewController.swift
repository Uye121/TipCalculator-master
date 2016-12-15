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
    @IBOutlet weak var adjustableTipsBAr: UISegmentedControl!
    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var tipsInput: UITextField!
    @IBOutlet weak var peopleInput: UITextField!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet var setting: UIView!
    @IBOutlet var mainView: UIView!
    
    var redValue: CGFloat = 0.0
    var greenValue: CGFloat = 0.0
    var blueValue: CGFloat = 0.0
    var opacityValue: CGFloat = 1.0
    
    var tipPercentages: [Double] = [0.18, 0.20, 0.25]
    var bill: Double?
    var tip: Double?
    var total: Double?
    var perPerson: Double?
    var people: Int = 1
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard (setting) != nil else {
            peopleInput.text = String(people)
            return
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var red: Float = 0.5
        var green: Float = 0.5
        var blue: Float = 0.5
        
        guard (setting) != nil else {
            let index = Int(defaults.string(forKey: "selectedIndex")!)
            let value = Double(defaults.string(forKey: "changeTip")!)!
            
            tipPercentages[Int(index!)] = Double(value)/100
            tipsBar.setTitle("\(Int(value))%", forSegmentAt: Int(index!))
            
            // Change color
            if defaults.string(forKey: "red") != nil {
                red = Float(defaults.string(forKey: "red")!)!
                green = Float(defaults.string(forKey: "green")!)!
                blue = Float(defaults.string(forKey: "blue")!)!
            } else {
                red = 0.5
                green = 0.5
                blue = 0.5
            }
            
            print("red: \(red), green: \(green), blue: \(blue)")
            mainView.backgroundColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(opacityValue))
            return
        }
        
        let index = Int(defaults.string(forKey: "selectedIndex")!)
        let value = Double(defaults.string(forKey: "changeTip")!)!
        
        adjustableTipsBAr.setTitle("\(Int(value))%", forSegmentAt: Int(index!))
        
        // Change color
        if defaults.string(forKey: "red") != nil {
            red = Float(defaults.string(forKey: "red")!)!
            green = Float(defaults.string(forKey: "green")!)!
            blue = Float(defaults.string(forKey: "blue")!)!
        } else {
            red = 0.5
            green = 0.5
            blue = 0.5
        }

        redSlider.value = red
        greenSlider.value = green
        blueSlider.value = blue
        print("red: \(red), green: \(green), blue: \(blue)")
        setting.backgroundColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(opacityValue))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func onTapSetting(_ sender: Any) {
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
        guard total != nil else {
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
    
    @IBAction func tapSetTips(_ sender: Any) {
        let tipAdjustAmount = Int(tipsInput.text!) ?? 0
        
        tipPercentages[adjustableTipsBAr.selectedSegmentIndex] = Double(tipAdjustAmount)
        adjustableTipsBAr.setTitle(String("\(tipAdjustAmount)%"), forSegmentAt: adjustableTipsBAr.selectedSegmentIndex)
        
        defaults.set(adjustableTipsBAr.selectedSegmentIndex, forKey: "selectedIndex")
        defaults.set(tipAdjustAmount, forKey: "changeTip")
        
    }
    
    @IBAction func changeRed(_ sender: Any) {
        redValue = CGFloat(redSlider.value)
        
        setting.backgroundColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: opacityValue)
        defaults.set(redValue, forKey: "red")
    }
    
    @IBAction func changeGreen(_ sender: Any) {
        greenValue = CGFloat(greenSlider.value)
        
        setting.backgroundColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: opacityValue)
        defaults.set(greenValue, forKey: "green")
    }
    
    @IBAction func changeBlue(_ sender: Any) {
        blueValue = CGFloat(blueSlider.value)
        
        setting.backgroundColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: opacityValue)
        defaults.set(blueValue, forKey: "blue")
    }
    
}

