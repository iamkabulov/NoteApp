//
//  Item.swift
//  ToDoApp
//
//  Created by Кабулов Нурсултан Пернебаевич on 25.12.2022.
//

import Foundation

class Item: NSObject, NSCoding {

	static let Dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
	static let ArchiveURL = Dir.appendingPathComponent("items")
	var name: String

	init?(name: String) {
		self.name = name
		super.init()
	}

	func encode(with aCoder: NSCoder) {
		aCoder.encode(name, forKey: "name")
	}
	required convenience init?(coder aDecoder: NSCoder) {
		let name = aDecoder.decodeObject(forKey: "name") as! String
		self.init(name: name)
	}
}
