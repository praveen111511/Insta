//
//  MessageViewController.swift
//  Insta
//
//  Created by Toqsoft on 02/01/25.
//

import UIKit
struct Users: Codable {
    let name: String
    let image: String
    let activeStatus: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case image
        case activeStatus = "active_status"
    }
}

struct UserResponses: Codable {
    let users: [Users]
}

class MessageViewController: UIViewController ,MessageTableViewCellDelegate {
    
    var getData: UserResponses?
    var filteredUsers: [Users] = []
    var allUsers: [Users] = []

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: "MessageTableViewCell")
        
        apiCall()
    }
    
    @IBAction func editNameBtn(_ sender: Any) {
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
    func apiCall(){
        let url = URL(string: "https://mocki.io/v1/1d285936-492e-44b6-ad44-bd9280402055")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { data, response, error in
            let decoder = JSONDecoder()
            do{
                let result = try decoder.decode(UserResponses.self, from: data!)
                DispatchQueue.main.async {
                    self.getData = result
                    self.allUsers = result.users
                                       self.filteredUsers = self.allUsers
                                       self.tableView.reloadData()
                }
            }catch{
                
            }
        }.resume()
    }
    func didUpdateSearchText(_ searchText: String) {
        if searchText.isEmpty {
                    filteredUsers = allUsers
                } else {
                    filteredUsers = allUsers.filter { $0.name.lowercased().contains(searchText.lowercased()) }
                }
                tableView.reloadData()
    }
    
    
}
extension MessageViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredUsers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell")as! MessageTableViewCell
        let data = filteredUsers[indexPath.row]
        cell.userName.text = data.name
        if let profileImageUrl = URL(string: data.image ) {
            cell.userImage.loadImage(from: profileImageUrl)
        }
        cell.uaserActive.text = data.activeStatus
        cell.delegate = self
        cell.configureCell(at: indexPath)
        return cell
    }
}
