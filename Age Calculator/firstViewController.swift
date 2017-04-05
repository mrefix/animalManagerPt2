//
//  ViewController.swift
//  Age Calculator
//
//  Created by Kuhn, Artie R Mr. on 1/31/17.
//  Copyright © 2017 artiekuhn. All rights reserved.
//

import UIKit

class firstViewController: UIViewController {
    
    
    @IBOutlet weak var animalPicker: UISegmentedControl!
    
    @IBOutlet weak var animalAgeInput: UITextField!
    @IBOutlet weak var animalNameInput: UITextField!
    
    @IBOutlet weak var promptLabel: UILabel!
    
    @IBOutlet weak var emptyAgeWarningLabel: UILabel!
    @IBOutlet weak var emptyNameWarningLabel: UILabel!
    
    // This variable is to prevent this page from always going straight to the second view if there were values found in cold storage.  True is a go ahead, false means stay here
    // This variable should be true if this page was loaded straight from start
    // It will be false if first view was loaded from second
    var shouldGoStraightToSecondView = true;
    
    @IBAction func animalSelected(_ sender: Any) {
        let animalTypes = ["Dog", "Cat", "Horse"]
        promptLabel.text = "Enter your \(animalTypes[animalPicker.selectedSegmentIndex].lowercased())'s age in human years."
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        print("segue checked")
        if !animalAgeInput.text!.isEmpty, Int(animalAgeInput.text!) != nil {
            emptyAgeWarningLabel.text = ""
            
            if !animalNameInput.text!.isEmpty {
                print("segue passed")
                emptyNameWarningLabel.text = ""
                return true;
            } else {
                print("segue denied")
                emptyNameWarningLabel.text = "* You must enter a name!"
                return false;
            }
            
        } else {
            if animalNameInput.text!.isEmpty, Int(animalAgeInput.text!) != nil {
                emptyNameWarningLabel.text = "* You must enter a name!"
            } else {
                emptyNameWarningLabel.text = ""
            }
            print("segue denied")
            emptyAgeWarningLabel.text = "* You must enter a number!"
            return false;
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("segue performed")
        let nextController = segue.destination as! secondViewController
        nextController.animalSelected = animalPicker.selectedSegmentIndex
        nextController.animalAge = Int(animalAgeInput.text!)!
        nextController.animalName = animalNameInput.text!
        
        // Putting cold storage saves here so that validation can prevent this from happening
        UserDefaults.standard.set(animalNameInput.text, forKey: "animalNameColdStorage")
        UserDefaults.standard.set(animalAgeInput.text, forKey: "animalAgeColdStorage")
        UserDefaults.standard.set(animalPicker.selectedSegmentIndex, forKey: "animalSelectedColdStorage")
    }
    
    
    override func viewDidLoad() {
        emptyNameWarningLabel.text = ""
        emptyAgeWarningLabel.text = ""
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let animalPickerSegmentFromColdStorage = UserDefaults.standard.object(forKey: "animalSelectedColdStorage") {
            // Hey there!  Because the validation doesn't allow anything to get saved unless it's all or nothing,
            // I only have to check for the existence of one of the three userDefaults.
            animalPicker.selectedSegmentIndex = animalPickerSegmentFromColdStorage as! Int
            animalNameInput.text = UserDefaults.standard.object(forKey: "animalNameColdStorage") as? String
            animalAgeInput.text = UserDefaults.standard.object(forKey: "animalAgeColdStorage") as? String
            let animalTypes = ["Dog", "Cat", "Horse"]
            promptLabel.text = "Enter your \(animalTypes[animalPicker.selectedSegmentIndex].lowercased())'s age in human years."
            print(shouldGoStraightToSecondView)
            
            if shouldGoStraightToSecondView {
                print("should go to second")
                self.performSegue(withIdentifier: "theOnlySegueFromFirstToSecondViewControllerIsThisOneRightHere", sender: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

