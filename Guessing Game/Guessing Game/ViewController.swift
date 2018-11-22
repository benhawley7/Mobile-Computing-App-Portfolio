//
//  ViewController.swift
//  Guessing Game
//
//  Created by Ben Hawley on 11/10/2018.
//  Copyright © 2018 Ben Hawley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var guessInput: UITextField!

    @IBOutlet weak var guessResult: UILabel!
    
    @IBAction func guessBtn(_ sender: UIButton) {
        // Is there actually an inputted value? I.e. not nil
        guard let input = guessInput.text else {
            guessResult.text = "Please input a guess."
            return
        }
        
        // Is the input an integer?
        guard let inputInt = Int(input) else {
            guessResult.text = "Please input an integer."
            return
        }
    
        // The input is valid, lets resign the keyboard invoked by the text field
        guessInput.resignFirstResponder()
        
        // Also reset the text field
        guessInput.text = ""
        
        // Lets roll two dice and total the score
        let firstRoll = Int.random(in: 1..<7) //value between 1 and 6
        let secondRoll = Int.random(in: 1..<7) //value between 1 and 6
        let totalScore = firstRoll + secondRoll
        
        
        // Does the input match the roll? Output result accordingly
        if (totalScore == inputInt) {
            guessResult.text = "Correct! You guessed \(inputInt),  I rolled \(totalScore), with a \(firstRoll) and \(secondRoll)!"
        } else {
            guessResult.text = "Incorrect! You guessed \(inputInt), I rolled \(totalScore), with a \(firstRoll) and \(secondRoll)!"
        }
    

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Set the number input fields keyboard type to be a number pad
        guessInput.keyboardType = UIKeyboardType.numberPad
        
    }


}

