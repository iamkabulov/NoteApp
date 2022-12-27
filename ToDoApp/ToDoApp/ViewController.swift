//
//  ViewController.swift
//  ToDoApp
//
//  Created by Кабулов Нурсултан Пернебаевич on 25.12.2022.
//

import UIKit

class ViewController: UIViewController {
	var item: Item?
	@IBOutlet weak var nameTextfield: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		if let item = item {
			nameTextfield.text = item.name
		}
	}

	@IBAction func saveItem(_ sender: UIBarButtonItem) {
	}

	@IBAction func cancel(_ sender: UIBarButtonItem) {
		let isInAddMode = presentingViewController is UINavigationController
		if isInAddMode {
			navigationController?.popViewController(animated: true)
			dismiss(animated: true, completion: nil)
		}
		else {
			navigationController!.popViewController(animated: true)
		}
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if sender is UIBarButtonItem {
			let name = nameTextfield.text ?? ""
			item = Item(name: name)
		}
	}
}

