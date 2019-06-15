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
    
    var trip: Trip?
    var temp_place: GMSPlace?
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    

    var placesClient: GMSPlacesClient!
    
    var addEventDelegate: AddEventDelegate?
    @IBOutlet weak var eventTitle: UITextField!
    @IBOutlet weak var destination: UITextField!
    @IBOutlet weak var duration: UITextField!
    @IBOutlet weak var startDate: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        placesClient = GMSPlacesClient.shared()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func launchPlaceLookup(_ sender: Any) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        // Specify the place data types to return.
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
            UInt(GMSPlaceField.placeID.rawValue) | UInt(GMSPlaceField.coordinate.rawValue))!
        autocompleteController.placeFields = fields
        
        // Specify a filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .noFilter
        //        autocompleteController.auto
        let lat = trip!.coordinates!.latitude
        let lon = trip!.coordinates!.longitude
        let northeEastBound = CLLocationCoordinate2D(latitude: lat - 0.5, longitude: lon - 0.5)
        let southWestBound = CLLocationCoordinate2D(latitude: lat + 0.5, longitude: lon + 0.5)
        let bounds = GMSCoordinateBounds(coordinate: northeEastBound, coordinate: southWestBound)
        autocompleteController.autocompleteFilter = filter
        autocompleteController.autocompleteBounds = bounds
        autocompleteController.autocompleteBoundsMode = .restrict
        //        autocompleteController.autocompleteBounds = .
        
        // Display the autocomplete view controller.
        present(autocompleteController, animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        //        print(place.addressComponents)
        print(place.coordinate)
        print(place.name!)
        print(place.placeID)
        temp_place = place
        destination.text = place.name!
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addEvent(_ sender: Any) {
        let title = self.eventTitle.text!
        let duration = Int(self.duration.text!)!
        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        let start = dateFormatter.string(from: self.startDate.date)
        let newEvent = TripEvent(title: title, start: self.startDate.date, duration: duration, place: temp_place!, databaseId: nil)
        _ = self.addEventDelegate!.addEvent(newEvent: newEvent)
        navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
