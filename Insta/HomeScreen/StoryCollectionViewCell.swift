//
//  StoryCollectionViewCell.swift
//  Insta
//
//  Created by Toqsoft on 31/12/24.
//

import UIKit

class StoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var storyImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        storyImage.layer.cornerRadius = 37
    }

}
