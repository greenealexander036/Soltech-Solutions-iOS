//
//  PlantsService.swift
//  Soltech-Solutions
//
//  Created by Alexander Greene on 9/26/17.
//  Copyright © 2017 Alexander Greene. All rights reserved.
//

import Foundation
import RealmSwift

class PlantsService {
	static let instance = PlantsService()

//	private let plantFamilies = [
//		PlantFamily(id: 0, name: "Common House Plants", imageName: "common_house_plants"),
//		PlantFamily(id: 1, name: "Dwarf Fruit Trees", imageName: "dwarf_fruit_trees"),
//		PlantFamily(id: 2, name: "Orchids", imageName: "orchids"),
//		PlantFamily(id: 3, name: "Herbs", imageName: "herbs")
//	]
//
//	private let allPlantProfiles = [
//		PlantProfile(id: 0, name: "African Violet", imageName: "common_house_plant", plantFamilyId: 0),
//		PlantProfile(id: 1, name: "Aluminum Plant", imageName: "common_house_plant", plantFamilyId: 0),
//		PlantProfile(id: 2, name: "Arrowhead Vine", imageName: "common_house_plant", plantFamilyId: 0),
//		PlantProfile(id: 3, name: "Asparagus Fern", imageName: "common_house_plant", plantFamilyId: 0),
//		PlantProfile(id: 4, name: "Violet", imageName: "common_house_plant", plantFamilyId: 0),
//		PlantProfile(id: 5, name: "African Violet", imageName: "dwarf_fruit_tree", plantFamilyId: 1),
//		PlantProfile(id: 6, name: "Aluminum Plant", imageName: "dwarf_fruit_tree", plantFamilyId: 1),
//		PlantProfile(id: 7, name: "Arrowhead Vine", imageName: "dwarf_fruit_tree", plantFamilyId: 1),
//		PlantProfile(id: 8, name: "Asparagus Fern", imageName: "dwarf_fruit_tree", plantFamilyId: 1),
//		PlantProfile(id: 9, name: "Violet", imageName: "dwarf_fruit_tree", plantFamilyId: 1),
//		PlantProfile(id: 10, name: "African Violet", imageName: "orchid", plantFamilyId: 2),
//		PlantProfile(id: 11, name: "Aluminum Plant", imageName: "orchid", plantFamilyId: 2),
//		PlantProfile(id: 12, name: "Arrowhead Vine", imageName: "orchid", plantFamilyId: 2),
//		PlantProfile(id: 13, name: "Asparagus Fern", imageName: "orchid", plantFamilyId: 2),
//		PlantProfile(id: 14, name: "Violet", imageName: "orchid", plantFamilyId: 2),
//		PlantProfile(id: 15, name: "African Violet", imageName: "herb", plantFamilyId: 3),
//		PlantProfile(id: 16, name: "Aluminum Plant", imageName: "herb", plantFamilyId: 3),
//		PlantProfile(id: 17, name: "Arrowhead Vine", imageName: "herb", plantFamilyId: 3),
//		PlantProfile(id: 18, name: "Asparagus Fern", imageName: "herb", plantFamilyId: 3),
//		PlantProfile(id: 19, name: "Violet", imageName: "herb", plantFamilyId: 3),
//	]
//
//	private let allPlants = [
//		Plant(id: 0, plantFamilyId: 0, name: "African Violet", imageName: "common_house_plant", optimalLightIntensity: 0, lightCycle: "Provide light for 16-18 hours each day in the vegetative stage. Leggy stems and no blooms indicate that it is not getting enough light. This plant will fail to bloom if it does not get 8 hours of darkness every night.", wateringTendencies: "Keep soil moist but not soggy; water from the bottom.", otherTips: ["Keep root growth restricted slightly and do not repot", "Use peat moss or African violet potting soil"]),
//		Plant(id: 1, plantFamilyId: 0, name: "Aluminum Plant", imageName: "common_house_plant", optimalLightIntensity: 1, lightCycle: "Provide light for 16-18 hours each day in the vegetative stage. Leggy stems and no blooms indicate that it is not getting enough light. This plant will fail to bloom if it does not get 8 hours of darkness every night.", wateringTendencies: "Keep soil moist but not soggy; water from the bottom.", otherTips: ["Keep root growth restricted slightly and do not repot", "Use peat moss or African violet potting soil"]),
//		Plant(id: 2, plantFamilyId: 0, name: "Arrowhead Vine", imageName: "common_house_plant", optimalLightIntensity: 2, lightCycle: "Provide light for 16-18 hours each day in the vegetative stage. Leggy stems and no blooms indicate that it is not getting enough light. This plant will fail to bloom if it does not get 8 hours of darkness every night.", wateringTendencies: "Keep soil moist but not soggy; water from the bottom.", otherTips: ["Keep root growth restricted slightly and do not repot", "Use peat moss or African violet potting soil"]),
//		Plant(id: 3, plantFamilyId: 0, name: "Asparagus Fern", imageName: "common_house_plant", optimalLightIntensity: 0, lightCycle: "Provide light for 16-18 hours each day in the vegetative stage. Leggy stems and no blooms indicate that it is not getting enough light. This plant will fail to bloom if it does not get 8 hours of darkness every night.", wateringTendencies: "Keep soil moist but not soggy; water from the bottom.", otherTips: ["Keep root growth restricted slightly and do not repot", "Use peat moss or African violet potting soil"]),
//		Plant(id: 4, plantFamilyId: 0, name: "Violet", imageName: "common_house_plant", optimalLightIntensity: 1, lightCycle: "Provide light for 16-18 hours each day in the vegetative stage. Leggy stems and no blooms indicate that it is not getting enough light. This plant will fail to bloom if it does not get 8 hours of darkness every night.", wateringTendencies: "Keep soil moist but not soggy; water from the bottom.", otherTips: ["Keep root growth restricted slightly and do not repot", "Use peat moss or African violet potting soil"]),
//		Plant(id: 5, plantFamilyId: 1, name: "African Violet", imageName: "dwarf_fruit_tree", optimalLightIntensity: 0, lightCycle: "Provide light for 16-18 hours each day in the vegetative stage. Leggy stems and no blooms indicate that it is not getting enough light. This plant will fail to bloom if it does not get 8 hours of darkness every night.", wateringTendencies: "Keep soil moist but not soggy; water from the bottom.", otherTips: ["Keep root growth restricted slightly and do not repot", "Use peat moss or African violet potting soil"]),
//		Plant(id: 6, plantFamilyId: 1, name: "Aluminum Plant", imageName: "dwarf_fruit_tree", optimalLightIntensity: 1, lightCycle: "Provide light for 16-18 hours each day in the vegetative stage. Leggy stems and no blooms indicate that it is not getting enough light. This plant will fail to bloom if it does not get 8 hours of darkness every night.", wateringTendencies: "Keep soil moist but not soggy; water from the bottom.", otherTips: ["Keep root growth restricted slightly and do not repot", "Use peat moss or African violet potting soil"]),
//		Plant(id: 7, plantFamilyId: 1, name: "Arrowhead Vine", imageName: "dwarf_fruit_tree", optimalLightIntensity: 2, lightCycle: "Provide light for 16-18 hours each day in the vegetative stage. Leggy stems and no blooms indicate that it is not getting enough light. This plant will fail to bloom if it does not get 8 hours of darkness every night.", wateringTendencies: "Keep soil moist but not soggy; water from the bottom.", otherTips: ["Keep root growth restricted slightly and do not repot", "Use peat moss or African violet potting soil"]),
//		Plant(id: 8, plantFamilyId: 1, name: "Asparagus Fern", imageName: "dwarf_fruit_tree", optimalLightIntensity: 0, lightCycle: "Provide light for 16-18 hours each day in the vegetative stage. Leggy stems and no blooms indicate that it is not getting enough light. This plant will fail to bloom if it does not get 8 hours of darkness every night.", wateringTendencies: "Keep soil moist but not soggy; water from the bottom.", otherTips: ["Keep root growth restricted slightly and do not repot", "Use peat moss or African violet potting soil"]),
//		Plant(id: 9, plantFamilyId: 1, name: "Violet", imageName: "dwarf_fruit_tree", optimalLightIntensity: 1, lightCycle: "Provide light for 16-18 hours each day in the vegetative stage. Leggy stems and no blooms indicate that it is not getting enough light. This plant will fail to bloom if it does not get 8 hours of darkness every night.", wateringTendencies: "Keep soil moist but not soggy; water from the bottom.", otherTips: ["Keep root growth restricted slightly and do not repot", "Use peat moss or African violet potting soil"]),
//		Plant(id: 10, plantFamilyId: 2, name: "African Violet", imageName: "orchid", optimalLightIntensity: 0, lightCycle: "Provide light for 16-18 hours each day in the vegetative stage. Leggy stems and no blooms indicate that it is not getting enough light. This plant will fail to bloom if it does not get 8 hours of darkness every night.", wateringTendencies: "Keep soil moist but not soggy; water from the bottom.", otherTips: ["Keep root growth restricted slightly and do not repot", "Use peat moss or African violet potting soil"]),
//		Plant(id: 11, plantFamilyId: 2, name: "Aluminum Plant", imageName: "orchid", optimalLightIntensity: 1, lightCycle: "Provide light for 16-18 hours each day in the vegetative stage. Leggy stems and no blooms indicate that it is not getting enough light. This plant will fail to bloom if it does not get 8 hours of darkness every night.", wateringTendencies: "Keep soil moist but not soggy; water from the bottom.", otherTips: ["Keep root growth restricted slightly and do not repot", "Use peat moss or African violet potting soil"]),
//		Plant(id: 12, plantFamilyId: 2, name: "Arrowhead Vine", imageName: "orchid", optimalLightIntensity: 2, lightCycle: "Provide light for 16-18 hours each day in the vegetative stage. Leggy stems and no blooms indicate that it is not getting enough light. This plant will fail to bloom if it does not get 8 hours of darkness every night.", wateringTendencies: "Keep soil moist but not soggy; water from the bottom.", otherTips: ["Keep root growth restricted slightly and do not repot", "Use peat moss or African violet potting soil"]),
//		Plant(id: 13, plantFamilyId: 2, name: "Asparagus Fern", imageName: "orchid", optimalLightIntensity: 0, lightCycle: "Provide light for 16-18 hours each day in the vegetative stage. Leggy stems and no blooms indicate that it is not getting enough light. This plant will fail to bloom if it does not get 8 hours of darkness every night.", wateringTendencies: "Keep soil moist but not soggy; water from the bottom.", otherTips: ["Keep root growth restricted slightly and do not repot", "Use peat moss or African violet potting soil"]),
//		Plant(id: 14, plantFamilyId: 2, name: "Violet", imageName: "orchid", optimalLightIntensity: 1, lightCycle: "Provide light for 16-18 hours each day in the vegetative stage. Leggy stems and no blooms indicate that it is not getting enough light. This plant will fail to bloom if it does not get 8 hours of darkness every night.", wateringTendencies: "Keep soil moist but not soggy; water from the bottom.", otherTips: ["Keep root growth restricted slightly and do not repot", "Use peat moss or African violet potting soil"]),
//		Plant(id: 15, plantFamilyId: 3, name: "African Violet", imageName: "herb", optimalLightIntensity: 0, lightCycle: "Provide light for 16-18 hours each day in the vegetative stage. Leggy stems and no blooms indicate that it is not getting enough light. This plant will fail to bloom if it does not get 8 hours of darkness every night.", wateringTendencies: "Keep soil moist but not soggy; water from the bottom.", otherTips: ["Keep root growth restricted slightly and do not repot", "Use peat moss or African violet potting soil"]),
//		Plant(id: 16, plantFamilyId: 3, name: "Aluminum Plant", imageName: "herb", optimalLightIntensity: 1, lightCycle: "Provide light for 16-18 hours each day in the vegetative stage. Leggy stems and no blooms indicate that it is not getting enough light. This plant will fail to bloom if it does not get 8 hours of darkness every night.", wateringTendencies: "Keep soil moist but not soggy; water from the bottom.", otherTips: ["Keep root growth restricted slightly and do not repot", "Use peat moss or African violet potting soil"]),
//		Plant(id: 17, plantFamilyId: 3, name: "Arrowhead Vine", imageName: "herb", optimalLightIntensity: 2, lightCycle: "Provide light for 16-18 hours each day in the vegetative stage. Leggy stems and no blooms indicate that it is not getting enough light. This plant will fail to bloom if it does not get 8 hours of darkness every night.", wateringTendencies: "Keep soil moist but not soggy; water from the bottom.", otherTips: ["Keep root growth restricted slightly and do not repot", "Use peat moss or African violet potting soil"]),
//		Plant(id: 18, plantFamilyId: 3, name: "Asparagus Fern", imageName: "herb", optimalLightIntensity: 0, lightCycle: "Provide light for 16-18 hours each day in the vegetative stage. Leggy stems and no blooms indicate that it is not getting enough light. This plant will fail to bloom if it does not get 8 hours of darkness every night.", wateringTendencies: "Keep soil moist but not soggy; water from the bottom.", otherTips: ["Keep root growth restricted slightly and do not repot", "Use peat moss or African violet potting soil"]),
//		Plant(id: 19, plantFamilyId: 3, name: "Violet", imageName: "herb", optimalLightIntensity: 1, lightCycle: "Provide light for 16-18 hours each day in the vegetative stage. Leggy stems and no blooms indicate that it is not getting enough light. This plant will fail to bloom if it does not get 8 hours of darkness every night.", wateringTendencies: "Keep soil moist but not soggy; water from the bottom.", otherTips: ["Keep root growth restricted slightly and do not repot", "Use peat moss or African violet potting soil"])
//	]
//
//	func getPlantFamilies() -> [PlantFamily] {
//		return plantFamilies
//	}
//
//	func getPlant(with plantId: Int) -> Plant {
//		let plant = allPlants.filter { (plant) -> Bool in
//			plant.id == plantId
//		}
//		return plant[0]
//	}
//
//	func getPlants(with familyId: Int) -> [PlantProfile] {
//		let desiredPlants = allPlantProfiles.filter { (profile) -> Bool in
//			return profile.plantFamilyId == familyId
//		}
//
//		return desiredPlants
//	}

/*	func writeDataToRealm() {
		let realm = try! Realm()

		for plant in allPlants {
			let image = UIImage(named: plant.imageName)!
			let imageData = UIImageJPEGRepresentation(image, 1)!

			let rPlant = RealmPlant()
			rPlant.id = plant.id
			rPlant.name = plant.name
			rPlant.familyId = plant.plantFamilyId
			rPlant.image = imageData
			rPlant.optimalLightIntensity = plant.optimalLightIntensity.rawValue
			rPlant.lightCycle = plant.lightCycle
			rPlant.wateringTendencies = imageData
			rPlant.otherTips = plant.otherTips[0]
			rPlant.arduinoMessage = ""

			try! realm.write {
				realm.add(rPlant)
			}
		}

		var image = UIImage(named: "paul_hodges")!
		var imageData = UIImageJPEGRepresentation(image, 1)!
		try! realm.write {
			let person = RealmPerson()
			person.name = "Paul Hodges"
			person.position = "Chief Executive Officer"
			person.image = imageData
			realm.add(person)
		}
		image = UIImage(named: "michael_planar")!
		imageData = UIImageJPEGRepresentation(image, 1)!
		try! realm.write {
			let person = RealmPerson()
			person.name = "Michael Planar"
			person.position = "Design and Development Engineer"
			person.image = imageData
			realm.add(person)
		}
		image = UIImage(named: "chris_clark")!
		imageData = UIImageJPEGRepresentation(image, 1)!
		try! realm.write {
			let person = RealmPerson()
			person.name = "Chris Clark"
			person.position = "Chief Marketing Officer"
			person.image = imageData
			realm.add(person)
		}

		do {
			try realm.writeCopy(toFile: URL(string: "/Users/alexandergreene/Desktop/soltech.realm")!)
		} catch let error {
			print(error)
		}
	}
*/
}































