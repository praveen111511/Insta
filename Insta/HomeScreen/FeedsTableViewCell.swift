//
//  FeedsTableViewCell.swift
//  Insta
//
//  Created by Toqsoft on 31/12/24.
//

import UIKit

class FeedsTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var profileImageTop: NSLayoutConstraint!
    @IBOutlet weak var backViewHeight: NSLayoutConstraint!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var storyCollectionView: UICollectionView!
    @IBOutlet weak var captionLbl: UILabel!
    @IBOutlet weak var cmtLbl: UILabel!
    @IBOutlet weak var likeCntLbl: UILabel!
    @IBOutlet weak var cmtBtn: UIButton!
    @IBOutlet weak var heartBtn: UIButton!
    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    var indexPath: IndexPath?
    var getData: [User]?
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImage.layer.cornerRadius = 25
        storyCollectionView.delegate = self
        storyCollectionView.dataSource = self
        storyCollectionView.register(UINib(nibName: "StoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "StoryCollectionViewCell")
        apiCall()
    }
    func apiCall(){
        let url = URL(string: "https://mocki.io/v1/30ef4406-a8a6-4b45-ab5c-080062729761")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { data, response, error in
            let decoder = JSONDecoder()
            do{
                let result = try decoder.decode([User].self, from: data!)
                DispatchQueue.main.async {
                    self.getData = result
//                    print("Response ----->\(result)")
                    self.storyCollectionView.reloadData()
                }
            }catch{
                
            }
        }.resume()
    }


   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(at indexPath: IndexPath) {
            self.indexPath = indexPath
        if indexPath.row == 0 {
                // Set the constraints for the first cell
                backViewHeight.constant = 450
            collectionViewHeight.constant = 110
                profileImageTop.constant = 10 // 10 from collection view
            } else {
                // Set the constraints for all other cells
                backViewHeight.constant = 350
                collectionViewHeight.constant = 0
                profileImageTop.constant = 10 // 10 from back view
            }
           
           // Hide the collection view for non-first cells
            storyCollectionView.isHidden = indexPath.row != 0
        }
    @IBAction func cmtBtn(_ sender: Any) {
    }
    @IBAction func heartBtn(_ sender: Any) {
    }
}
extension FeedsTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = storyCollectionView.dequeueReusableCell(withReuseIdentifier: "StoryCollectionViewCell", for: indexPath)as! StoryCollectionViewCell
        let data = getData?[indexPath.row]
        if let profileImageUrl = URL(string: data?.userImage ?? "") {
            cell.storyImage.loadImage(from: profileImageUrl) // Use an extension to load images
           
        }
        cell.userName.text = data?.userName
        return cell
    }
    
    
}


//story json
//[{"userImage":"https://randomuser.me/api/portraits/men/1.jpg","userName":"JohnDoe"},{"userImage":"https://randomuser.me/api/portraits/women/1.jpg","userName":"JaneSmith"},{"userImage":"https://randomuser.me/api/portraits/men/2.jpg","userName":"MichaelBrown"},{"userImage":"https://randomuser.me/api/portraits/women/2.jpg","userName":"EmilyClark"},{"userImage":"https://randomuser.me/api/portraits/men/3.jpg","userName":"ChrisJohnson"},{"userImage":"https://randomuser.me/api/portraits/women/3.jpg","userName":"SarahDavis"},{"userImage":"https://randomuser.me/api/portraits/men/4.jpg","userName":"DavidMartinez"},{"userImage":"https://randomuser.me/api/portraits/women/4.jpg","userName":"AnnaGarcia"},{"userImage":"https://randomuser.me/api/portraits/men/5.jpg","userName":"DanielLee"},{"userImage":"https://randomuser.me/api/portraits/women/5.jpg","userName":"SophiaTaylor"},{"userImage":"https://randomuser.me/api/portraits/men/6.jpg","userName":"JamesHarris"},{"userImage":"https://randomuser.me/api/portraits/women/6.jpg","userName":"OliviaWilson"},{"userImage":"https://randomuser.me/api/portraits/men/7.jpg","userName":"EthanWalker"},{"userImage":"https://randomuser.me/api/portraits/women/7.jpg","userName":"MiaYoung"},{"userImage":"https://randomuser.me/api/portraits/men/8.jpg","userName":"LiamRobinson"},{"userImage":"https://randomuser.me/api/portraits/women/8.jpg","userName":"IsabellaHall"},{"userImage":"https://randomuser.me/api/portraits/men/9.jpg","userName":"NoahAllen"},{"userImage":"https://randomuser.me/api/portraits/women/9.jpg","userName":"AvaAdams"},{"userImage":"https://randomuser.me/api/portraits/men/10.jpg","userName":"LucasPerez"},{"userImage":"https://randomuser.me/api/portraits/women/10.jpg","userName":"CharlotteEvans"},{"userImage":"https://randomuser.me/api/portraits/men/11.jpg","userName":"BenjaminHernandez"},{"userImage":"https://randomuser.me/api/portraits/women/11.jpg","userName":"AmeliaKing"},{"userImage":"https://randomuser.me/api/portraits/men/12.jpg","userName":"HenryScott"},{"userImage":"https://randomuser.me/api/portraits/women/12.jpg","userName":"EllaGreen"},{"userImage":"https://randomuser.me/api/portraits/men/13.jpg","userName":"AlexanderBaker"},{"userImage":"https://randomuser.me/api/portraits/women/13.jpg","userName":"GraceTurner"},{"userImage":"https://randomuser.me/api/portraits/men/14.jpg","userName":"SebastianPhillips"},{"userImage":"https://randomuser.me/api/portraits/women/14.jpg","userName":"ChloeCampbell"},{"userImage":"https://randomuser.me/api/portraits/men/15.jpg","userName":"JacksonParker"},{"userImage":"https://randomuser.me/api/portraits/women/15.jpg","userName":"VictoriaCollins"}]
