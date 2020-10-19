//
//  ViewController.swift
//  ForwarReverseGeoCoding
//
//  Created by Rajesh Mani on 19/10/20.
//

import UIKit
import CoreLocation

class ForwardGeocodingViewController: UIViewController {
    @IBOutlet var countryTextField: UITextField!
    @IBOutlet var streetTextField: UITextField!
    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var geoCodeButton: UIButton!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet var locationLabel: UILabel!
    let geoCoder = CLGeocoder()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        activityIndicatorView.isHidden = true
        
    }

    @IBAction func geoCode(sender: UIButton){
        guard let country = countryTextField.text else { return }
        guard let street = streetTextField.text  else { return }
        guard let city = cityTextField.text  else { return }
        let address = "\(country), \(street), \(city)"
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
                // Process Response
                self.processResponse(withPlacemarks: placemarks, error: error)
            }
        geoCodeButton.isHidden = true
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
    }
    
    
    
    func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?){
        //update view
        geoCodeButton.isHidden = false
        activityIndicatorView.stopAnimating()
        activityIndicatorView.isHidden = true

        if let error = error {
            print("Unable to forward Geocode address \(error)")
            locationLabel.text = "Unable to find location label for Address"
        } else {
            var location: CLLocation?
            if let placemarks = placemarks, placemarks.count > 0 {
                location = placemarks.first?.location
            }
            if let location = location {
                let coordinate = location.coordinate
                locationLabel.text = "\(coordinate.latitude) : \(coordinate.longitude)"
            } else {
                locationLabel.text = "No Matching location found!"
            }
        }
        
    }

}




extension CLPlacemark {

    var compactAddress: String? {
        if let name = name {
            var result = name

            if let street = thoroughfare {
                result += ", \(street)"
            }

            if let city = locality {
                result += ", \(city)"
            }

            if let country = country {
                result += ", \(country)"
            }

            return result
        }

        return nil
    }

}
