//
//  ViewController.swift
//  ToDoApp2
//
//  Created by Ben Hawley on 01/11/2018.
//  Copyright © 2018 Ben Hawley. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var activities = ["No activities"]
    
    @IBOutlet weak var activityTable: UITableView!
    @IBOutlet weak var activityInput: UITextField!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var context: NSManagedObjectContext?

    // Set the number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count;
    }
    
    // Set the cell data using the index path row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get the cell
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "myCell")
        
        // Write the cells text label output and return the cell
        cell.textLabel?.text = activities[indexPath.row] as String
        return cell;
    }
    

    // When  the save button is pressed
    @IBAction func activitySave(_ sender: UIButton) {
        // No text? Don't save
        guard let newActivityValue = activityInput.text else {
            return
        }
        
        // Create a new core data activity
        let newActivity = NSEntityDescription.insertNewObject(forEntityName: "Activity", into: context!) as! Activity
        newActivity.setValue(newActivityValue, forKey: "value")
        
        // Save the core data
        do {
            try context?.save()
            print("Saved")
            
        } catch {
            print("there was an error")
        }
        
        // Update the activities array
        updateActivities()
        
        // Reload the data in the table
        activityTable.reloadData()
        
    }
    
    func updateActivities() {
        // Do any additional setup after loading the view, typically from a nib.
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Activity")
        request.returnsObjectsAsFaults = false
        // Set the sort descriptor
        request.sortDescriptors?.append(NSSortDescriptor(key: "creationDate", ascending: true))
        
        // Get the items from core data
        do {
            let results = try context?.fetch(request)
            if (results?.count)! > 0 {
                activities = []
                // For every activity in CoreData add it to the array
                for result in results as! [NSManagedObject] {
                    if let activity = result.value(forKey: "value") as? String {
                        activities.append(activity)
                    }
                }
            }
        } catch {
            print("Couldn't fetch results")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the context
        context = appDelegate.persistentContainer.viewContext
        
        // Get the list activities from CoreData
        updateActivities()
        
    }


}

