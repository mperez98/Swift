//
//  Pet.swift
//  pet_team_wireframe
//
//  Created by Mathew Perez on 11/19/18.
//  Copyright © 2018 Pet Team. All rights reserved.
//

import Foundation
import UIKit

class Pet {
    var name: String
    var breed: String
    var age: String
    var gender: String
    var image: UIImage?
    
    init(name: String, breed: String, age: String, gender: String, image: UIImage?) {
        self.name = name
        self.breed = breed
        self.age = age
        self.gender = gender
        self.image = image
    }
}
