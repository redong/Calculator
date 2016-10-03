//
//  CalculatorModel.swift
//  Calculator
//
//  Created by Ren Dong on 9/27/16.
//  Copyright © 2016 Ren Dong. All rights reserved.
//

import Foundation

class CalculatorModel {
    
    fileprivate var accumulator = 0.0
    fileprivate var binaryFunction: PendingBinaryOperationInfo?
    
    struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var operand: Double
    }
    
    //Types of operations
    var operations: Dictionary<String, Operation> = [
        "π" : .constant(M_PI),
        "√" : .unary(sqrt),
        "±" : .unary{-$0},
        "x^2" : .unary{ (op1) -> Double in return pow(op1, 2)},
        "x^3" : .unary{ (op1) -> Double in return pow(op1, 3)},
        "10^x" : .unary{ (op1) -> Double in return pow(10, op1)},
        "%" : .unary{ (op1) -> Double in return op1 * 0.01},
        "+" : .binary{ (op1, op2) -> Double in return op1 + op2},
        "-" : .binary{ (op1, op2) -> Double in return op1 - op2},
        "×" : .binary{ (op1, op2) -> Double in return op1 * op2},
        "÷" : .binary{ (op1, op2) -> Double in return op1 / op2},
        "=" : .equals
    ]
    
    enum Operation {
        case unary((Double) -> Double)
        case binary((Double, Double) -> Double)
        case constant(Double)
        case equals
    }
    
    func setOperand(operand: Double){
        accumulator = operand
    }
    
    func performOperation(symbol: String) {
        guard let operation = operations[symbol] else {
            return
        }
        switch operation {
        case .constant(let constant): accumulator = constant
        case .unary(let function): accumulator = function(accumulator)
        case .binary(let function):
            binaryFunction = PendingBinaryOperationInfo(binaryFunction: function, operand: accumulator)
        case .equals:
            if let functionInfo = binaryFunction {
                accumulator = functionInfo.binaryFunction(functionInfo.operand, accumulator)
                binaryFunction = nil
            }
            
        }
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
}
