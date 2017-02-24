//
//  ChatTableViewCell.swift
//  ParseChat
//
//  Created by Daniel Ku on 2/23/17.
//  Copyright © 2017 djku. All rights reserved.
//

import UIKit
import Parse
class ChatTableViewCell: UITableViewCell {
    @IBOutlet weak var chatMessage: UILabel!
    @IBOutlet weak var username: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
