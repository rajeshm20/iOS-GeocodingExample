//
//  ReverseGeocodingViewController.swift
//  ForwarReverseGeoCoding
//
//  Created by Rajesh Mani on 19/10/20.
//

import UIKit
import CoreLocation

class ReverseGeocodingViewController: UIViewController {

    @IBOutlet var lattitudeTextFld: UITextField!
    @IBOutlet var longitudeTextField: UITextField!
    @IBOutlet var geoCodeButton: UIButton!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet var locationLabel: UILabel!
    lazy var geoCoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - நாம் இங்கு ஆக்சன் செட் பன்னலாம்

    @IBAction func geocode(_ sender: UIButton) {
        guard let latAsString = lattitudeTextFld.text, let lat = Double(latAsString) else { return }
        guard let lonAsString = longitudeTextField.text, let lon = Double(lonAsString) else {
            return
        }
        
        // create location
        let location = CLLocation(latitude: lat, longitude: lon)
        
        // Geocode Location
           geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
               // Process Response
               self.processResponse(withPlacemarks: placemarks, error: error)
           }

            print("\(lat), \(lon)")

        // Update View
        geoCodeButton.isHidden = true
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
    }
    
    func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?){
        
        // Update View
           geoCodeButton.isHidden = false
           activityIndicatorView.stopAnimating()
           activityIndicatorView.isHidden = true

        if let error = error {
                print("Unable to Reverse Geocode Location (\(error))")
                locationLabel.text = "Unable to Find Address for Location"

            } else {
                if let placemarks = placemarks, let placemark = placemarks.first {
                    locationLabel.text = placemark.compactAddress
                } else {
                    locationLabel.text = "No Matching Addresses Found"
                }
            }
        
        
        
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



