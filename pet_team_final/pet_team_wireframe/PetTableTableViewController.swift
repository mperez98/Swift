//
//  PetTableTableViewController.swift
//  pet_team_wireframe
//
//  Created by Mathew Perez on 11/19/18.
//  Copyright © 2018 Pet Team. All rights reserved.
//

import UIKit
import CoreData

class PetTableTableViewController: UITableViewController {
    // everyone we've liked.
    var likedIds = [String]()
    
    // all pets data.
    var pets = [String:[String]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 90.0
        getLikedIds()
        getPets()
    }
    
    func getLikedIds() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let requestLike = NSFetchRequest<NSFetchRequestResult>(entityName: "Like")
        requestLike.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(requestLike)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    likedIds += [result.value(forKey: "id") as! String]
                }
            }
        } catch {}
        print("likedIds")
        print(likedIds)
    }
    
    func getPets() {
        if let path = Bundle.main.path(forResource: "Pets", ofType: "plist"),
            let data = NSDictionary(contentsOfFile: path){
                pets = data as! [String:[String]]
        }
        print(pets)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return likedIds.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PetTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PetTableViewCell

        cell.cellName.text = "Name: " + pets[likedIds[indexPath.row]]![1]
        cell.cellBreed.text = "Breed: " + pets[likedIds[indexPath.row]]![3]
        cell.cellAge.text = "Age: " + pets[likedIds[indexPath.row]]![4]
        cell.cellGender.text = "Gender: " + pets[likedIds[indexPath.row]]![2]
        cell.cellImage.image = UIImage(named: likedIds[indexPath.row])

        return cell
    }
    
    // when user selects row..
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = URL(string: pets[likedIds[indexPath.row]]![5])
        var html = ""
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            // get HTML.
            html = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)! as String
            html = html.replacingOccurrences(of: "\n", with: "")
            
            // get description if exists...
            var description = "No Description"
            let pattern = "<span id=\"lbDescription\">(?<des>.*?)</span>"
            let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            if let match = regex?.firstMatch(in: html, options: [], range: NSRange(location: 0, length: html.utf16.count)) {
                if let range = Range(match.range(withName: "des"), in: html) {
                    description = String(html[range])
                    let regex2 = try? NSRegularExpression(pattern: "<[^>]*>", options: .caseInsensitive)
                    description = regex2!.stringByReplacingMatches(in: description, range: NSMakeRange(0, description.count), withTemplate: " ")
                }
            }

            // alert description.
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Description", message: String(description), preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        task.resume()
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // deleting liked pet.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            print("DELETING...")
            
            // delete from CORE DATA.
            let currentId = likedIds[indexPath.row]
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Like")
            do {
                let results = try context.fetch(request)
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        let resultId = result.value(forKey: "id") as! String
                        if currentId == resultId {
                            context.delete(result)
                            break
                        }
                    }
                }
            } catch {}
            
            do {
                try context.save()
            } catch let error as NSError {
                print("Could not delete. \(error), \(error.userInfo)")
            }
            
            // Delete from view.
            self.likedIds.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
//            self.tableView.reloadData()
        }
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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

}
