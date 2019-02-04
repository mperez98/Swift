//
//  PetSelectViewController.swift
//  pet_team_wireframe
//
//  Created by Mathew Perez on 11/19/18.
//  Copyright © 2018 Pet Team. All rights reserved.
//

import UIKit
import CoreData

class PetSelectViewController: UIViewController {
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dislikeButton: UIButton!
    @IBOutlet weak var petLargeView: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    var type = ""
    var gender = ""
    var minAge = ""
    var maxAge = ""
    var breed = ""
    
    // all pets in Pet.plist.
    var pets = [String]() // IDs
    var names = [String]() // Names
    
    var currentPet = "" // Id
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup gestures.
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipe(sender:)))
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipe(sender:)))
        leftSwipe.direction = .left
        view.addGestureRecognizer(rightSwipe)
        view.addGestureRecognizer(leftSwipe)
        
        gatherPets()
        
        displayPet()
    }
    
    // gesture handler.
    @objc func swipe(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            switch sender.direction {
            case .right:
                dislike()
                displayPet()
                bounce(item: dislikeButton)
            case .left:
                like()
                displayPet()
                bounce(item: likeButton)
            default:
                break
            }
        }
    }
    
    func gatherPets()  {
        // Get all Liked and Disliked pets from Core Data, B/C we don't want to show
        // Pets we've already seen.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let requestLike = NSFetchRequest<NSFetchRequestResult>(entityName: "Like")
        let requestDislike = NSFetchRequest<NSFetchRequestResult>(entityName: "Dislike")
        requestLike.returnsObjectsAsFaults = false
        requestDislike.returnsObjectsAsFaults = false
        var alreadyLookedAt = [String]()
        do {
            let results = try context.fetch(requestLike)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    alreadyLookedAt += [result.value(forKey: "id") as! String]
                }
            }
        } catch {}
        do {
            let results = try context.fetch(requestDislike)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    alreadyLookedAt += [result.value(forKey: "id") as! String]
                }
            }
        } catch {}
        print("alreadyLookedAt")
        print(alreadyLookedAt)
        
        // Search throught Pets.plist...
        if let path = Bundle.main.path(forResource: "Pets", ofType: "plist"),
            let data = NSDictionary(contentsOfFile: path){
            for (id, info) in data {
                let array = info as! [String]
                
                // Skip if we've already seen pet...
                if (alreadyLookedAt.contains(id as! String)) {
                    continue
                }
                
                // Skip if pet does not match search...
                if (type != "" && array[0] != type) {
                    continue
                }
                if (gender != "" && array[2] != gender) {
                    continue
                }
                if (Int(minAge) == Int(maxAge)){
                    if (Int(array[4]) != Int(minAge)) {
                        continue
                    }
                }
                if (Int(minAge) != Int(maxAge)) {
                    if (Int(array[4])! < Int(minAge)! || Int(array[4])! > Int(maxAge)!) {
                        continue
                    }
                }
                /*if (minAge != "" && Int(array[4])! <= Int(minAge)!) {
                    continue
                }
                if (maxAge != "" && Int(array[4])! >= Int(maxAge)!) {
                    continue
                }*/
                if (breed != "" && array[3].lowercased() != breed.lowercased()) {
                    continue
                }
                
                // otherwise, save pet.
                pets += [id as! String]
                names += [array[1]]
            }
        }
        print(pets)
    }
    
    
    func displayPet() {
        // If no more pets, go home.
        if (pets.count <= 0) {
            let alert = UIAlertController(title: "Sorry!", message: "There are no more pets to look at!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler:  {(action:UIAlertAction!) in
                self.navigationController?.popViewController(animated: true)
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        // otherwise, get next pet.
        currentPet = pets.removeFirst()
        name.text = names.removeFirst()
        petLargeView.image = UIImage(named: currentPet)
    }

    @IBAction func likePet(_ sender: Any) {
        like()
        displayPet()
        bounce(item: likeButton)
    }
    
    func like() {
        if currentPet != "" {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.insertNewObject(forEntityName: "Like", into: context)
            entity.setValue(currentPet, forKey: "id")
            do {
                try context.save()
            } catch {
                
            }
        }
    }
    
    @IBAction func dislikePet(_ sender: Any) {
        dislike()
        displayPet()
        bounce(item: dislikeButton)
    }
    
    func dislike() {
        if currentPet != "" {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.insertNewObject(forEntityName: "Dislike", into: context)
            entity.setValue(currentPet, forKey: "id")
            do {
                try context.save()
            } catch {
                
            }
        }
    }
    
    // Core Animation
    func bounce(item: UIView) {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: [.curveLinear, .autoreverse], animations: {
            item.center.y = item.center.y - 50
        }, completion: { finished in item.center.y = item.center.y + 50
        })
    }

}
