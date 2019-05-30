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
    
    var data = [
        "titles": ["New York", "California", "London"],
        "images": [UIImage(named: "New-York"), UIImage(named: "California"), UIImage(named: "London")],
//        "images": ["New-York", "California", "London"],
        "subtitles": ["Easter break", "Semester break", "Christmas break"]
    ]
    
    let CELL_TRIP = "tripCell"
    
    
    let SECTION_TRIP = 0
    var placesClient: GMSPlacesClient!

    override func viewDidLoad() {
        super.viewDidLoad()
        placesClient = GMSPlacesClient.shared()
        
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Add",
//                                                           style: .plain,
//                                                           target: self,
//                                                           action: #selector(TripsTableViewController.showPlacesLookup))
        
//        rightBarButton.type
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func showPlacesLookup() {
//        let
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let placesLookupVC =  storyboard.instantiateViewController(withIdentifier: "PlaceLookupViewController")
//        let placesVC = PlaceLookupViewController()
//        self.present(placesVC, animated: true, completion: nil)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data["titles"]!.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tripCell = tableView.dequeueReusableCell(withIdentifier: CELL_TRIP, for: indexPath) as! TripTableViewCell
        let trip = Trip(title: data["titles"]![indexPath.row] as! String, thumbnail: data["images"]![indexPath.row] as! UIImage, subtitle: data["subtitles"]![indexPath.row] as! String)
        tripCell.inflate(trip: trip)
        
        return tripCell
    }
    
//    override func tableView(_ tableView: UITableView,
//                            heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 192.00
//    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func autocompleteClicked() {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        // Specify the place data types to return.
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
            UInt(GMSPlaceField.placeID.rawValue))!
        autocompleteController.placeFields = fields
        
        // Specify a filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .city
        autocompleteController.autocompleteFilter = filter
        
        // Display the autocomplete view controller.
        present(autocompleteController, animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        data["titles"]!.append(place.name)
        data["subtitles"]!.append("Work break")
        self.fetchPhoto(place.placeID!)
        print("Place name: \(place.name)")
        print("Place ID: \(place.placeID)")
        print("Place attributions: \(place.attributions)")
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
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
    
    func fetchPhoto(_ placeId: String?){
        // Specify the place data types to return (in this case, just photos).
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.photos.rawValue))!
        
        placesClient?.fetchPlace(fromPlaceID: placeId!,
                                 placeFields: fields,
                                 sessionToken: nil, callback: {
                                    (place: GMSPlace?, error: Error?) in
                                    if let error = error {
                                        print("An error occurred: \(error.localizedDescription)")
                                        return
                                    }
                                    if let place = place {
                                        // Get the metadata for the first photo in the place photo metadata list.
                                        let photoMetadata: GMSPlacePhotoMetadata = place.photos![0]
                                        
                                        // Call loadPlacePhoto to display the bitmap and attribution.
                                        self.placesClient?.loadPlacePhoto(photoMetadata, callback: { (photo, error) -> Void in
                                            if let error = error {
                                                // TODO: Handle the error.
                                                print("Error loading photo metadata: \(error.localizedDescription)")
                                                return
                                            } else {
                                                // Display the first image and its attributions.
                                                print("photo attached")
                                                self.data["images"]!.append(photo!)
                                                self.tableView.reloadData()
//                                                self.lblText?.attributedText = photoMetadata.attributions;
                                            }
                                        })
                                    }
        })
    }
    
}
