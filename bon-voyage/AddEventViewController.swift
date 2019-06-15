//
//  AddEventViewController.swift
//  bon-voyage
//
//  Created by Harsil Patel on 30/5/19.
//  Copyright © 2019 Harsil Patel. All rights reserved.
//

import UIKit
import GooglePlaces

class AddEventViewController: UIViewController, GMSAutocompleteViewControllerDelegate {
    
    // Trip will be the city user wishes to travel
    var trip: Trip?
    
    // The destination selected in the city
    var selectedPlace: GMSPlace?
    
    var addEventDelegate: AddEventDelegate?
    var placesClient = AppCommons.sharedInstance.placesClient

    // outlets to get data from the view controller
    @IBOutlet weak var eventTitle: UITextField!
    @IBOutlet weak var destination: UITextField!
    @IBOutlet weak var duration: UITextField!
    @IBOutlet weak var startDate: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Will be executed when the Destination field is pressed
    @IBAction func launchPlaceLookup(_ sender: Any) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        // We want the name, placeID and the coordinates of the place
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
            UInt(GMSPlaceField.placeID.rawValue) | UInt(GMSPlaceField.coordinate.rawValue))!
        autocompleteController.placeFields = fields
        
        // We want the user to be go anywhere in the city, therefore .noFilter
        let filter = GMSAutocompleteFilter()
        filter.type = .noFilter
        autocompleteController.autocompleteFilter = filter


        // We assume the city to be 1 latitude long and 1 latitude wide centered at the city's coordinates
        // therefore we bound the searchable area to give results of establishments from only that city.
        let lat = trip!.tripLat!
        let lon = trip!.tripLon!
        let northeEastBound = CLLocationCoordinate2D(latitude: lat - 0.5, longitude: lon - 0.5)
        let southWestBound = CLLocationCoordinate2D(latitude: lat + 0.5, longitude: lon + 0.5)
        let bounds = GMSCoordinateBounds(coordinate: northeEastBound, coordinate: southWestBound)
        autocompleteController.autocompleteBounds = bounds
        
        // We can use BoundsMode .bias to give prediction preference to establishments in the bounds over those
        // that are out of bounds, however, by using .restrict we restrict results to only the ones that are in the bounds
        autocompleteController.autocompleteBoundsMode = .restrict
        
        // Display the autocomplete view controller.
        present(autocompleteController, animated: true, completion: nil)
    }
    
    // We update the selectedPlace and the destination field's text to chosen place.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        selectedPlace = place
        destination.text = place.name!
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addEvent(_ sender: Any) {
        var message = ""
        var isEventValid = true
        
        if (self.eventTitle.text?.isEmpty)!  {
            message += "\nPlease enter the title"
            isEventValid = false
        }
        if (Int(self.duration.text!) == nil)  {
            message += "\nEnsure duration is integer"
            isEventValid = false
        }
        if (selectedPlace == nil) {
            message += "\nPlease choose a destination"
            isEventValid = false
        }
    
        
        if (isEventValid) {
            let title = self.eventTitle.text!
            let duration = Int(self.duration.text!)!
            
            let newEvent = TripEvent(title: title, start: self.startDate.date, duration: duration, place: selectedPlace!, databaseId: nil)
            _ = self.addEventDelegate!.addEvent(newEvent: newEvent)
            navigationController?.popViewController(animated: true)
        } else {
            let alertController = UIAlertController(title: "Please verify the details", message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }

}
