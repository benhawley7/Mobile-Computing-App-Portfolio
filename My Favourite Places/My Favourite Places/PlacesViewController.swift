//
//  PlacesViewController.swift
//  My Favourite Places
//
//  Created by Ben Hawley on 01/11/2018.
//  Copyright © 2018 Ben Hawley. All rights reserved.
//

import UIKit

// Global Variables
var places = [Dictionary<String, String>()]
var currentPlace = -1
class PlacesViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Get Places from CoreData
        let defaults = UserDefaults.standard
        places = defaults.array(forKey: "places") as! [Dictionary<String, String>]

    }

    @IBOutlet var table: UITableView!

    // Set the number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // Set the number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }

    // Set the cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
            if places[indexPath.row]["name"] != nil {
                cell.textLabel?.text = places[indexPath.row]["name"]
            }
            return cell
    }
    
    // Before a segue
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentPlace = indexPath.row
        performSegue(withIdentifier: "to Map", sender: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // When the view comes back, we need to update the places
        if places.count == 1 && places[0].count == 0 {
            places.remove(at: 0)
            places.append(["name":"Ashton Building", "lat": "53.406566", "lon": "-2.966531"])
        }

        currentPlace = -1
        table.reloadData()
    }


    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            places.remove(at: indexPath.row);
            tableView.deleteRows(at: [indexPath], with: .fade)
            let defaults = UserDefaults.standard
            defaults.set(places, forKey: "places")
        }
    }


}
