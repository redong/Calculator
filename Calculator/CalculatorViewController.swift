//
//  ViewController.swift
//  Calculator
//
//  Created by Ren Dong on 9/25/16.
//  Copyright © 2016 Ren Dong. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    @IBOutlet fileprivate weak var display: UILabel!
    
    fileprivate let calculartorModel = CalculatorModel()
    fileprivate var isTyping = false
    
    fileprivate var textInDisplay: Double? {
        get {
            return  Double(display.text!)
        }
        
        set {
            display.text = String(newValue!)
        }
    }
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if isTyping {
            display.text = display.text! + digit
        } else {
            display.text = digit
        }
        isTyping = true
    }
    
    @IBAction func touchOperand(_ sender: UIButton) {
        
        if isTyping {
            calculartorModel.setOperand(operand: textInDisplay!)
            isTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            calculartorModel.performOperation(symbol: mathematicalSymbol)
        }
        textInDisplay = calculartorModel.result
    }

    @IBAction func clear(_ sender: UIButton) {
        display.text = String(0)
    }
    @IBAction func decimalPoint(_ sender: UIButton) {
        let decimalPoint = sender.currentTitle!
        if let currentDisplay = display.text, !currentDisplay.contains(decimalPoint) {
            display.text = display.text! + decimalPoint
        }
    }
}

