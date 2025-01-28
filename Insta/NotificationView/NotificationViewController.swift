//
//  NotificationViewController.swift
//  Insta
//
//  Created by Toqsoft on 02/01/25.
//

import UIKit
struct Section {
    let title: String
    let messages: [UserMessage]
}

class NotificationViewController: UIViewController {
    
    var sections: [(title: String, messages: [UserMessage])] = []
    @IBOutlet weak var notificationTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationTableView.dataSource = self
        notificationTableView.delegate = self
        notificationTableView.register(UINib(nibName: "NotificationTableViewCell", bundle: nil), forCellReuseIdentifier: "NotificationTableViewCell")
        apiCall()
    }
    func apiCall(){
        let url = URL(string: "https://mocki.io/v1/30e7dda1-e56e-4e84-9232-5563a5366ff0")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { data, response, error in
            let decoder = JSONDecoder()
            do{
                let result = try decoder.decode(MessagesData.self, from: data!)
                DispatchQueue.main.async {
                    self.sections = [
                                        ("Today", result.data.today),
                                        ("Yesterday", result.data.yesterday),
                                        ("Last 7 Days", result.data.last7Days),
                                        ("Last 30 Days", result.data.last30Days)
                                    ]
                    print("Response ----->\(result)")
                    self.notificationTableView.reloadData()
                }
            }catch{
                
            }
        }.resume()
    }

    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
extension NotificationViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notificationTableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell")as! NotificationTableViewCell
        let data = sections[indexPath.section].messages[indexPath.row]
        cell.Usermessage.text = data.message
        cell.userName.text = data.userName
        if let profileImageUrl = URL(string: data.userImage ?? "") {
            cell.userImage.loadImage(from: profileImageUrl) // Use an extension to load images
           
        }
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    

    
}


//notification json
//{"data":{"today":[{"userImage":"https://randomuser.me/api/portraits/men/1.jpg","userName":"JohnDoe","message":"Hello! How are you?"},{"userImage":"https://randomuser.me/api/portraits/women/1.jpg","userName":"JaneSmith","message":"Have a great day!"},{"userImage":"https://randomuser.me/api/portraits/men/2.jpg","userName":"MichaelBrown","message":"Letâ€™s meet up tomorrow."}],"yesterday":[{"userImage":"https://randomuser.me/api/portraits/women/2.jpg","userName":"EmilyClark","message":"Thanks for your help!"},{"userImage":"https://randomuser.me/api/portraits/men/3.jpg","userName":"ChrisJohnson","message":"See you soon!"}],"last7Days":[{"userImage":"https://randomuser.me/api/portraits/men/4.jpg","userName":"DavidMartinez","message":"Letâ€™s catch up later."},{"userImage":"https://randomuser.me/api/portraits/women/3.jpg","userName":"SarahDavis","message":"Can we reschedule?"},{"userImage":"https://randomuser.me/api/portraits/men/5.jpg","userName":"DanielLee","message":"Great job on the project!"},{"userImage":"https://randomuser.me/api/portraits/women/4.jpg","userName":"AnnaGarcia","message":"Iâ€™ll call you later."},{"userImage":"https://randomuser.me/api/portraits/men/6.jpg","userName":"JamesHarris","message":"Letâ€™s finalize the plan."}],"last30Days":[{"userImage":"https://randomuser.me/api/portraits/men/7.jpg","userName":"EthanWalker","message":"Meeting went well!"},{"userImage":"https://randomuser.me/api/portraits/women/5.jpg","userName":"SophiaTaylor","message":"Thanks for your input."},{"userImage":"https://randomuser.me/api/portraits/men/8.jpg","userName":"LiamRobinson","message":"Iâ€™ll send the documents."},{"userImage":"https://randomuser.me/api/portraits/women/6.jpg","userName":"OliviaWilson","message":"Can we talk later?"},{"userImage":"https://randomuser.me/api/portraits/men/9.jpg","userName":"NoahAllen","message":"Good morning!"},{"userImage":"https://randomuser.me/api/portraits/women/7.jpg","userName":"MiaYoung","message":"Donâ€™t forget about the deadline."},{"userImage":"https://randomuser.me/api/portraits/men/10.jpg","userName":"LucasPerez","message":"Happy to help!"},{"userImage":"https://randomuser.me/api/portraits/women/8.jpg","userName":"IsabellaHall","message":"It was nice seeing you."},{"userImage":"https://randomuser.me/api/portraits/men/11.jpg","userName":"BenjaminHernandez","message":"Letâ€™s plan a trip."},{"userImage":"https://randomuser.me/api/portraits/women/9.jpg","userName":"AvaAdams","message":"Thanks for the reminder."}]}}
