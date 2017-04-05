//
//  ViewController.swift
//  Age Calculator
//
//  Created by Kuhn, Artie R Mr. on 1/31/17.
//  Copyright © 2017 artiekuhn. All rights reserved.
//

import UIKit

class secondViewController: UIViewController {
    
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var recommendLabel: UILabel!
    @IBOutlet weak var recommendPicture: UIImageView!
    
    var animalSelected = 0
    var animalAge = 0
    var animalName = "Artie"
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextController = segue.destination as! firstViewController
        nextController.shouldGoStraightToSecondView = false;
    }
    
    override func viewDidLoad() {
        var animalTypes = ["Dog", "Cat", "Horse"]
        
        var animalNameAndYear = [
            "Dog" : 7,
            "Cat" : 6,
            "Horse" : 3
        ]
        
        // Used for product recommendation
        var ageRange = 0; // 0 is young, 1 is middle, 2 is old, 3 is no longer with us
        
        let selectedAnimalGeneralName = animalTypes[animalSelected]
        let selectedAnimalGivenName = animalName;
        let calculatedAnimalAge = animalAge * animalNameAndYear[selectedAnimalGeneralName]!
        
        
        header.text = "\(selectedAnimalGivenName)! What a great name for a \(selectedAnimalGeneralName.lowercased())!"
        
        // __Message__
        // message changes depending on the age of the dog.  Similar to first assignment
        
        var myResultText = "";
        
        if(calculatedAnimalAge < 8) {
            myResultText = "They be a youngin'!"
            if(animalSelected == 0) {
                myResultText += " Your carpet probably isn't white "
                    + "anymore with all those puppy pee stains."
            }
        } else if(calculatedAnimalAge == 16) {
            myResultText = "They're now able to drive!"
        } else if(calculatedAnimalAge < 20) {
            myResultText = "They're not too old!"
            ageRange = 1;
        } else if (calculatedAnimalAge < 40) {
            myResultText = "They're approaching middle age!"
            ageRange = 1;
        } else if (calculatedAnimalAge < 70) {
            myResultText = "They're approaching retirement."
            ageRange = 2;
        } else if (calculatedAnimalAge < 200){
            myResultText = "Start talking to the kids about the 'farm'."
            ageRange = 2;
        } else {
            myResultText = "6 feet under."
            ageRange = 3;
        }
        
        myResultText += " \(animalName) is \(calculatedAnimalAge) in \(selectedAnimalGeneralName.lowercased()) years."
        message.text = myResultText
        
        
        // __Recommended Products__
        
        var recommendationText = "I totally recommend...\n"
        var recommendedPictureChooser = [
            ["youngDog.jpeg", "middleDog.jpeg", "oldDog.jpeg", "dead.jpeg"], // Dog[0][.]
            ["cat.jpeg", "cat.jpeg", "cat.jpeg", "deadKitty.jpeg"], // Cat[1][.]
            ["youngHorse.jpeg", "middleHorse.jpeg", "oldHorse.jpeg", "dead.jpeg"], // Horse[2][.]
            ["dead.jpeg", "deadKitty.jpeg", "dead.jpeg", "dead.jpeg"] // Dead[3][.]
            ];
        
        // 0 is young, 1 is middle, 2 is old, 3 is no longer with us
        switch ageRange {
        case 0:
            if animalSelected == 0 {
                recommendationText += "Dog ice cream!!! "
            } else if animalSelected == 1 {
                recommendationText += "Cat nip. "
            } else if animalSelected == 2 {
                recommendationText += "Baby carrots. "
            } else {
                recommendationText = "Dead things cannot eat. "
            }
            break;
        case 1:
            if animalSelected == 0 {
                recommendationText += "American Journey dog food.  That Chinese crap contains metal scraps and they don't care.  It makes me angry. "
            } else if animalSelected == 1 {
                recommendationText += "Cat nip. Always. "
            } else if animalSelected == 2 {
                recommendationText += "Mature carrots. "
            } else {
                recommendationText = "Dead things cannot eat. "
            }
            break;
        case 2:
            if animalSelected == 0 {
                recommendationText += "Give it some real food.  Treat your dog until he hits the dirt. "
            } else if animalSelected == 1 {
                recommendationText += "Cat nip. Always. Always. "
            } else if animalSelected == 2 {
                recommendationText += "Old carrots. "
            } else {
                recommendationText = "Dead things cannot eat. "
            }
            break;
        case 3:
            recommendationText = "Dead things cannot eat. "
            break;
        default:
            recommendationText = "Something went wrong. "
        }
        
        recommendLabel.text = recommendationText + "Check out more at google!"  // Yes, I kept this for dead things.  People need to educated about dead animals.
        
        recommendPicture.image = UIImage(named: recommendedPictureChooser[animalSelected][ageRange])
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

