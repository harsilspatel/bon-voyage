//
//  TripsTableViewController.swift
//  bon-voyage
//
//  Created by Harsil Patel on 21/4/19.
//  Copyright © 2019 Harsil Patel. All rights reserved.
//

import UIKit
import GooglePlaces

class TripsTableViewController: UITableViewController, GMSAutocompleteViewControllerDelegate {
    
    @IBOutlet weak var rightBarButton: UIBarButtonItem!
    
    var raw_trips = [
        Trip(title: "New York", thumbnail: UIImage(named: "New-York")!, tripID: "ChIJOwg_06VPwokRYv534QaPC8g", lat: 40.7127753, lon: -74.0059728, databaseId: nil),
        Trip(title: "Los Angeles", thumbnail: UIImage(named: "California")!, tripID: "ChIJE9on3F3HwoAR9AhGJW_fL-I", lat: 34.0522342, lon: -118.2436849, databaseId: nil),
        Trip(title: "London", thumbnail: UIImage(named: "London")!, tripID: "ChIJdd4hrwug2EcRmSrV3Vo6llI", lat: 51.5073509, lon: -0.1277583, databaseId: nil)
    ]
    
    let CELL_TRIP = "tripCell"
    
    
    let SECTION_TRIP = 0
    let placesClient = AppCommons.sharedInstance.placesClient

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // only one section for trips
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // all Trips will be stored in one list
        return raw_trips.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // there will only be one type of cell TripTableViewCell
        let tripCell = tableView.dequeueReusableCell(withIdentifier: CELL_TRIP, for: indexPath) as! TripTableViewCell
        let trip = raw_trips[indexPath.row]
        tripCell.inflate(trip: trip)
        
        return tripCell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            raw_trips.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        let destination = segue.destination as! CalendarViewController
        let selectedIndexPath = tableView.indexPathsForSelectedRows?.first
        destination.trip = raw_trips[selectedIndexPath!.row]
    }
    
    @objc func autocompleteClicked() {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        // We want the name, placeID and the coordinates of the place.
        let fields: GMSPlaceField = GMSPlaceField(rawValue:
            UInt(GMSPlaceField.name.rawValue) |
            UInt(GMSPlaceField.photos.rawValue) |
            UInt(GMSPlaceField.placeID.rawValue) |
            UInt(GMSPlaceField.coordinate.rawValue))!
        autocompleteController.placeFields = fields
        
        // We only want the filter to be cities.
        let filter = GMSAutocompleteFilter()
        filter.type = .city
        autocompleteController.autocompleteFilter = filter
        
        // Display the autocomplete view controller.
        present(autocompleteController, animated: true, completion: nil)
    }
    
    // MARK: - Methods to conform to GMSAutocompleteViewControllerDelegate
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {

        
        let photoMetadata: GMSPlacePhotoMetadata = place.photos![0]
        
        var thumbnail: UIImage?
        // Call loadPlacePhoto to display the bitmap and attribution.
        self.placesClient.loadPlacePhoto(photoMetadata, callback: { (photo, error) -> Void in
            if (error != nil) {
                thumbnail = [UIImage(named: "New-York")!, UIImage(named: "California")!, UIImage(named: "London")!].randomElement()!
            } else {
                thumbnail = photo!
            }
            
            let lat = place.coordinate.latitude
            let lon = place.coordinate.longitude
            self.raw_trips.append(Trip(title: place.name!, thumbnail: thumbnail!, tripID: place.placeID!, lat: lat, lon: lon, databaseId: nil))
            self.tableView.reloadData()
        })
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    @IBAction func lookupCity(_ sender: Any) {
        autocompleteClicked()
    }
    
}
