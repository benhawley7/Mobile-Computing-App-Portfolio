//
//  ViewController.swift
//  Multiplication Table
//
//  Created by Ben Hawley on 16/10/2018.
//  Copyright © 2018 Ben Hawley. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Variable to store the current multiplier
    var multiplier = 0;
    
    // Outlets for the interface Elements
    @IBOutlet weak var multiplicationTable: UITableView!
    @IBOutlet weak var numberInputField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    // Action for the submission of the submit button
    @IBAction func submitBtn(_ sender: UIButton) {
        // Attempt to get the number input text
        guard let newMultiplierString = numberInputField.text else {
            // If there is no text, hide the table and reveal an error message
            multiplicationTable.isHidden = true;
            errorLabel.isHidden = false;
            errorLabel?.text = "Please input a number"
            return;
        }
        
        // Attempt to cast the multiplier string to an integer
        guard let newMultiplierInt = Int(newMultiplierString) else {
            // If the input is not an integer, hide the table and reveal an error message
            multiplicationTable.isHidden = true;
            errorLabel.isHidden = false;
            errorLabel?.text = "Please input an integer number"
            return;
        }
        // If the input is valid, resign the keyboerd
        numberInputField.resignFirstResponder()
        
        // Replace the existing multiplier with the new one
        multiplier = newMultiplierInt
        
        // Reload the data in the table to take into account the new multiplier
        multiplicationTable.reloadData()
        
        // In case we are coming from an error, make sure the correct elements are visible
        multiplicationTable.isHidden = false;
        errorLabel.isHidden = true;
    }

    // Return the number of rows the table view has
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    // Populate each row cell of the table virw
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get the cell
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "myCell")
        
        // Determine the other number multiplier based on the current now
        let number = indexPath.row + 1
        
        // Write the cells text label output and return the cell
        cell.textLabel?.text = "\(number) X \(multiplier) = \(number * multiplier)"
        return cell;
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Set up the keyboard type of the number pad
        numberInputField.keyboardType = UIKeyboardType.numberPad
        
        // Initially, we hide the table and the error message until we get the first input
        multiplicationTable.isHidden = true
        errorLabel.isHidden = true;
    }


}

