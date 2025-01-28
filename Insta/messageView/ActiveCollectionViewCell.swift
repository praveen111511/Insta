//
//  ActiveCollectionViewCell.swift
//  Insta
//
//  Created by Toqsoft on 02/01/25.
//

import UIKit


class ActiveCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var nameData: UILabel!
    @IBOutlet weak var imageData: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        greenView.layer.cornerRadius = 2.5
        imageData.layer.cornerRadius = 30
    }
    
}
