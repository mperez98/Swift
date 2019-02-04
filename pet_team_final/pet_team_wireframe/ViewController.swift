//
//  ViewController.swift
//  pet_team_wireframe
//
//  Created by Sienna on 11/18/18.
//  Copyright © 2018 Pet Team. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var agePicker: UIPickerView!
    @IBOutlet weak var breedPicker: UIPickerView!
    @IBOutlet weak var catButton: UIButton!
    @IBOutlet weak var dogButton: UIButton!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    var pickerDataCat: [String] = [String]()
    var pickerDataDog: [String] = [String]()
    var pickerDataDefault: [String] = [String]()
    var pickerAgeData: [[String]] = [[String]]()
    // Default search is empty string.
    var type = ""
    var gender = ""
    var minAge = "0"
    var maxAge = "16"
    var breed = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Connect data:
        self.breedPicker.delegate = self
        self.breedPicker.dataSource = self
        self.agePicker.delegate = self
        self.agePicker.dataSource = self
        
        // Initialize picker arrays
        pickerDataCat = ["All", "Manx", "Domestic Medium Hair", "Siamese", "Domestic Short Hair"]
        pickerDataDog = ["All", "Collie, Border/Mix", "Terrier/Mix", "Shepherd/Mix", "Terrier, Pit Bull", "Rottweiler/Mix", "Chihuahua/Mix", "Catahoula Leopard", "Pyrenees", "American Blue Heeler"]
        pickerDataDefault = ["All Cat and Dog Breeds"]
        pickerAgeData = [["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16"], ["16", "15", "14", "13", "12", "11", "10", "9", "8", "7", "6", "5", "4", "3", "2", "1", "0"]]
        // Setup text fields
        //ageTextField.delegate = self
        //breedTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // set search fields.
        //maxAge = ageTextField.text!
        
        // dismiss keyboard.
        //ageTextField.resignFirstResponder()
        //breedTextField.resignFirstResponder()
        
        return true
    }
    
    @IBAction func catIsTouched(_ sender: Any) {
        if (catButton.backgroundColor == UIColor(red: 136.0/255.0, green: 178.0/255.0, blue: 201.0/255.0, alpha: 1.0)) {
            type = ""
            catButton.backgroundColor = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1.0)
            self.breedPicker.reloadAllComponents()
        }
        else {
        type = "Cat"
        catButton.backgroundColor = UIColor(red: 136.0/255.0, green: 178.0/255.0, blue: 201.0/255.0, alpha: 1.0)
        dogButton.backgroundColor = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1.0)
        self.breedPicker.reloadAllComponents()
        }
    }
    
    @IBAction func dogIsTouched(_ sender: Any) {
        if (dogButton.backgroundColor == UIColor(red: 136.0/255.0, green: 178.0/255.0, blue: 201.0/255.0, alpha: 1.0)) {
            type = ""
            dogButton.backgroundColor = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1.0)
            self.breedPicker.reloadAllComponents()
        }
        else {
        type = "Dog"
        dogButton.backgroundColor = UIColor(red: 136.0/255.0, green: 178.0/255.0, blue: 201.0/255.0, alpha: 1.0)
        catButton.backgroundColor = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1.0)
        self.breedPicker.reloadAllComponents()
        }
    }
    
    @IBAction func maleIsTouched(_ sender: Any) {
        if (maleButton.backgroundColor == UIColor(red: 136.0/255.0, green: 178.0/255.0, blue: 201.0/255.0, alpha: 1.0)) {
            gender = ""
            maleButton.backgroundColor = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1.0)
        }
        else {
        gender = "Male"
        maleButton.backgroundColor = UIColor(red: 136.0/255.0, green: 178.0/255.0, blue: 201.0/255.0, alpha: 1.0)
        femaleButton.backgroundColor = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1.0)
        }
    }
    
    @IBAction func femaleIsTouched(_ sender: Any) {
        if (femaleButton.backgroundColor == UIColor(red: 136.0/255.0, green: 178.0/255.0, blue: 201.0/255.0, alpha: 1.0))  {
            gender = ""
            femaleButton.backgroundColor = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1.0)
        }
        else {
        gender = "Female"
        femaleButton.backgroundColor = UIColor(red: 136.0/255.0, green: 178.0/255.0, blue: 201.0/255.0, alpha: 1.0)
        maleButton.backgroundColor = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1.0)
        }
    }
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if (pickerView == breedPicker) {
            return 1
        }
        else {
            return 2
        }
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == breedPicker) {
            if (type == "Cat") {
                return pickerDataCat.count
            }
            else if (type == "Dog") {
                return pickerDataDog.count
            }
            else {
                return pickerDataDefault.count
            }
        }
        else {
            return pickerAgeData[0].count
        }
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == breedPicker) {
            if (type == "Cat") {
                return pickerDataCat[row]
            }
            else if (type == "Dog") {
                return pickerDataDog[row]
            }
            else {
                return pickerDataDefault[row]
            }
        }
        else {
            return pickerAgeData[component][row]
        }
    }
    
    // Capture the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        if (pickerView == breedPicker) {
            if (type == "Cat") {
                if (pickerDataCat[row] == "All") {
                    breed = ""
                } else {
                    breed = pickerDataCat[row]
                }
            }
            else if (type == "Dog") {
                if (pickerDataDog[row] == "All") {
                    breed = ""
                } else {
                    breed = pickerDataDog[row]
                }
            }
            else {
                breed = ""
            }
        }
        else {
            if (component == 0)
            {
                minAge = pickerAgeData[component][row]
            }
            else {
                maxAge = pickerAgeData[component][row]
            }
        }
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // when sequeing to search pets...
        if (minAge == "") {
            minAge = "0"
        }
        if (maxAge == "") {
            maxAge = "0"
        }
        if (minAge > maxAge) {
            let alert = UIAlertController(title: "The minimum age must be less than or equal to the maximum age", message: "Please fix your min. and max ages to continue the search", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            
            self.present(alert, animated: true)
            self.viewDidLoad()
        }
        
        if (segue.identifier == "viewPets") {
            let destinationVC = segue.destination as! PetSelectViewController
            destinationVC.type = type
            destinationVC.gender = gender
            destinationVC.minAge = minAge
            destinationVC.maxAge = maxAge
            destinationVC.breed = breed
        }
     }
    
}

