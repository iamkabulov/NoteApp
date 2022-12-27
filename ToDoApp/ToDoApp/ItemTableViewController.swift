//
//  ItemTableViewController.swift
//  ToDoApp
//
//  Created by Кабулов Нурсултан Пернебаевич on 25.12.2022.
//

import UIKit

class ItemTableViewController: UITableViewController {

    var items  = [Item.init(name: "Первая заметка")]
    

	override func viewDidLoad() {
		super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        self.navigationItem.leftBarButtonItem!.title = "Править"
        
		if let savedItems = loadItems() {
			items += savedItems
		}
	}

	@IBAction func unwindToList(sender: UIStoryboardSegue) {
		let srcViewCon = sender.source as? ViewController
		let item = srcViewCon?.item
		if (srcViewCon != nil && item?.name != "") {
			if let selectedIndexPath = tableView.indexPathForSelectedRow {
				items[selectedIndexPath.row] = item!
				tableView.reloadRows(at: [selectedIndexPath], with: .none)
				saveItems()
			}
			else {
				let newIndexPath = NSIndexPath(row: items.count, section: 0)
				items.append(item!)
				tableView.insertRows(at: [newIndexPath as IndexPath], with: .bottom)
				saveItems()
			}
		}
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(
			withIdentifier: "ItemTableViewCell", for: indexPath) as! ItemTableViewCell
		let item = items[indexPath.row]
        cell.ItemLabel.text = item?.name
		return cell
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "ShowDetail" {
			let detailVC = segue.destination as! ViewController

			// Get the cell that generated this segue.
			if let selectedCell = sender as? ItemTableViewCell {
				let indexPath = tableView.indexPath(for: selectedCell)!
				let selectedItem = items[indexPath.row]
				detailVC.item = selectedItem
			}
		}
		else if segue.identifier == "AddItem" {

		}
	}

	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			items.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .fade)
			saveItems()
			
		} else if editingStyle == .insert {
            //
		}
	}

	func saveItems() {
		let isSaved = NSKeyedArchiver.archiveRootObject(items, toFile: Item.ArchiveURL.path)
		if !isSaved {
			print("Failed to save items...")
		}
	}

	func loadItems() -> [Item]? {
		return NSKeyedUnarchiver.unarchiveObject(
			withFile: Item.ArchiveURL.path) as? [Item]
	}

	override func setEditing (_ editing:Bool, animated:Bool)
	{   
		super.setEditing(editing,animated:animated)
		self.editButtonItem.title = editing ? "Отменить" : "Удалить"
	}

	override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
		return "Удалить"
	}
}
