//
//  TableViewCell.swift
//  wongnai_assignment
//
//  Created by Nuntawat. Wisedsup on 7/11/2562 BE.
//  Copyright © 2562 Nuntawat. Wisedsup. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var voted: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        name.textColor=UIColor(hexFromString: "#1D1D1D")
        detail.textColor=UIColor(hexFromString: "#3F3F3F")
        voted.textColor=UIColor(hexFromString: "#979797")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
