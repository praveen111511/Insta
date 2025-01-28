//
//  MessageTableViewCell.swift
//  Insta
//
//  Created by Toqsoft on 02/01/25.
//

import UIKit
struct UserData: Codable {
    let name: String
    let image: String
}

struct UserResponse: Codable {
    let users: [UserData]
}
protocol MessageTableViewCellDelegate: AnyObject {
    func didUpdateSearchText(_ searchText: String)
}

class MessageTableViewCell: UITableViewCell, UITextFieldDelegate{
    weak var delegate: MessageTableViewCellDelegate?
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var activeCollectionView: UICollectionView!
    @IBOutlet weak var MainViewHeight: NSLayoutConstraint!
    @IBOutlet weak var oneTimeViewHeight: NSLayoutConstraint!
    @IBOutlet weak var fullTimeViewTop: NSLayoutConstraint!
    @IBOutlet weak var fullTimeView: UIView!
    @IBOutlet weak var uaserActive: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var oneTimeView: UIView!
    @IBOutlet weak var mainView: UIView!
    var indexPath: IndexPath?
    var getData: UserResponse?
    var filteredUsers: [UserData] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        activeCollectionView.delegate = self
        activeCollectionView.dataSource = self
        activeCollectionView.register(UINib(nibName: "ActiveCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ActiveCollectionViewCell")
        apiCall()
        userImage.layer.cornerRadius = 22.5
        searchTF.layer.cornerRadius = 5
        searchTF.placeholder = "Search User"
        searchTF.delegate = self
        searchTF.addTarget(self, action: #selector(searchTextChanged), for: .editingChanged)
        
    }
    @objc private func searchTextChanged() {
            delegate?.didUpdateSearchText(searchTF.text ?? "")

        }
    func configureCell(at indexPath: IndexPath) {
            self.indexPath = indexPath
        if indexPath.row != 0 {
            MainViewHeight.constant = 60
            oneTimeViewHeight.constant = 0
            }
           
           // Hide the collection view for non-first cells
        activeCollectionView.isHidden = indexPath.row != 0
        oneTimeView.isHidden = indexPath.row != 0
        searchTF.isHidden = indexPath.row != 0
        }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func apiCall(){
        let url = URL(string: "https://mocki.io/v1/4a3451e9-1681-4f99-b545-ce015e321806")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { data, response, error in
            let decoder = JSONDecoder()
            do{
                let result = try decoder.decode(UserResponse.self, from: data!)
                DispatchQueue.main.async {
                    self.getData = result
                    //                    print("Response ----->\(result)")
                    self.activeCollectionView.reloadData()
                }
            }catch{
                
            }
        }.resume()
    }
}

extension MessageTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getData?.users.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = activeCollectionView.dequeueReusableCell(withReuseIdentifier: "ActiveCollectionViewCell", for: indexPath)as! ActiveCollectionViewCell
        let data = getData?.users[indexPath.row]
        cell.nameData.text = data?.name
        if let profileImageUrl = URL(string: data?.image ?? "") {
            cell.imageData.loadImage(from: profileImageUrl) // Use an extension to load images
           
        }
        return cell
    }
    
    
}

//active json
//{"users":[{"name":"Alice Johnson","image":"https://randomuser.me/api/portraits/women/1.jpg"},{"name":"Bob Smith","image":"https://randomuser.me/api/portraits/men/1.jpg"},{"name":"Charlie Brown","image":"https://randomuser.me/api/portraits/men/2.jpg"},{"name":"David Lee","image":"https://randomuser.me/api/portraits/men/3.jpg"},{"name":"Emma Wilson","image":"https://randomuser.me/api/portraits/women/2.jpg"},{"name":"Frank Miller","image":"https://randomuser.me/api/portraits/men/4.jpg"},{"name":"Grace Davis","image":"https://randomuser.me/api/portraits/women/3.jpg"},{"name":"Hank Turner","image":"https://randomuser.me/api/portraits/men/5.jpg"},{"name":"Ivy Anderson","image":"https://randomuser.me/api/portraits/women/4.jpg"},{"name":"Jack White","image":"https://randomuser.me/api/portraits/men/6.jpg"}]}
