//: Playground - noun: a place where people can play

import UIKit

// Declare global immutable array variables
let dayList = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
let restaurantList = ["Salty Sow", "Kerbey Lane", "Milto's", "Trudy's", "Madam Mam's", "Vert's", "Teji's", "Home"]
let costList = [30, 10.99, 10.50, 11.70, 13.99, 7.99, 8.99, 0]
let tipList = [0.20, 0.18, 0.18, 0.18, 0.18, 0.15, 0.15, 0]

// Declare and initialize global mutable variables
var budgetLeft:Double = 0.0
var weeklyBudget:Double = 50.00
var dailyBudget = 0.0

// Loop through the 14 weeks of semester and add what was left over from previous week's budget
for i in 1...14 {
    print("Week " + String(i))
    weeklyBudget = 50.00 + budgetLeft
    // Loop through the 7 days of the week
    for x in 0...6 {
        var day:String = dayList[x] + " meal: "
        var restaurant:Int = Int(arc4random_uniform(8))
        var cost:Double = 0.0
        if restaurant == 7 {     // Account for Home having no tip or tax
            cost = costList[restaurant]
        } else {
            cost = costList[restaurant] * (1+tipList[restaurant]+0.0825)
        }
        if x == 0 {     // Initialize and begin updating daily budget on Sunday
            dailyBudget = weeklyBudget
            if dailyBudget - cost > 0 {
                dailyBudget = dailyBudget - cost
                print(day + restaurantList[restaurant] + ", budget now " + String(format: "%.2f", dailyBudget))
            } else {
                restaurant = Int(arc4random_uniform(8))
                if restaurant == 7 {
                    cost = costList[restaurant]
                } else {
                    cost = costList[restaurant] * (1+tipList[restaurant]+0.0825)
                }
                while dailyBudget - cost < 0 {      // Account for not having sufficient funds to eat out
                    restaurant = Int(arc4random_uniform(8))
                    if restaurant == 7 {
                        cost = costList[restaurant]
                    } else {
                        cost = costList[restaurant] * (1+tipList[restaurant]+0.0825)
                    }
                dailyBudget -= cost
                print(day + restaurantList[restaurant] + ", budget now " + String(format: "%.2f", dailyBudget))
                }
            }
        } else {    // Continue updating daily budget after Sunday through the rest of the week
            var dailyBudgetConstant:Double = dailyBudget
            if dailyBudget - cost > 0 {
                dailyBudget -= cost
                print(day + restaurantList[restaurant] + ", budget now " + String(format: "%.2f", dailyBudget))
            } else {
                restaurant = Int(arc4random_uniform(8))
                if restaurant == 7 {
                    cost = costList[restaurant]
                } else {
                    cost = costList[restaurant] * (1+tipList[restaurant]+0.0825)
                }
                while dailyBudgetConstant - cost < 0 {
                    restaurant = Int(arc4random_uniform(8))
                    if restaurant == 7 {
                        cost = costList[restaurant]
                    } else {
                        cost = costList[restaurant] * (1+tipList[restaurant]+0.0825)
                    }
                }
                dailyBudget -= cost
                print(day + restaurantList[restaurant] + ", budget now " + String(format: "%.2f", dailyBudget))
            }
        }
    }
    budgetLeft = dailyBudget  // Store left over budget from one week to be added to beginning budget of next week
}


