//
//  NotificationTableViewCell.swift
//  Insta
//
//  Created by Toqsoft on 02/01/25.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var Usermessage: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        userImage.layer.cornerRadius = 25
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
