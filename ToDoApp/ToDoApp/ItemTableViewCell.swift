//
//  ItemTableViewCell.swift
//  ToDoApp
//
//  Created by Кабулов Нурсултан Пернебаевич on 25.12.2022.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

	@IBOutlet weak var ItemLabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
