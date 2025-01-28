//
//  ViewController.swift
//  Insta
//
//  Created by Toqsoft on 31/12/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var feedsTableview: UITableView!

    var getData: [Post]?
    override func viewDidLoad() {
        super.viewDidLoad()
        apiCall()
        feedsTableview.showsVerticalScrollIndicator = false
        feedsTableview.showsHorizontalScrollIndicator = false
        feedsTableview.dataSource = self
        feedsTableview.delegate = self
        feedsTableview.register(UINib(nibName: "FeedsTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedsTableViewCell")
    }

    @IBAction func messageBtn(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(identifier: "MessageViewController")as! MessageViewController
        present(controller, animated: true)
    }
    @IBAction func notificationBtn(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(identifier: "NotificationViewController")as! NotificationViewController
        present(controller, animated: true)
    }
    func apiCall(){
        let url = URL(string: "https://mocki.io/v1/dbc6c5d5-1515-4317-9b58-ab5e505f4cf3")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { data, response, error in
            let decoder = JSONDecoder()
            do{
                let result = try decoder.decode([Post].self, from: data!)
                DispatchQueue.main.async {
                    self.getData = result
//                    print("Response ----->\(result)")
                    self.feedsTableview.reloadData()
                }
            }catch{
                
            }
        }.resume()
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(getData?.count ?? 0)
        return getData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = feedsTableview.dequeueReusableCell(withIdentifier: "FeedsTableViewCell")as! FeedsTableViewCell
        let data = getData?[indexPath.row]
        cell.captionLbl.text = "\(data?.name ?? "") - \(data?.caption ?? "")"
        cell.cmtLbl.text = "\(data?.comments.count ?? 0)"
        cell.likeCntLbl.text = "\(data?.likes ?? 0)"
        cell.nameLbl.text = data?.name
        if let FeedImageUrl = URL(string: data?.postImage ?? "") {
            cell.feedImage.loadImage(from: FeedImageUrl)
        }
        
        if let profileImageUrl = URL(string: data?.profileImage ?? "") {
            cell.profileImage.loadImage(from: profileImageUrl) // Use an extension to load images
           
        }
        cell.configureCell(at: indexPath)
        return cell
    }
}
extension UIImageView {
    func loadImage(from url: URL) {
        // Set a placeholder image (if any)
        self.image = UIImage(named: "placeholder")

        // Load image asynchronously
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
}
//feed json
//[{"name":"John Doe","profile_image":"https://img.freepik.com/premium-vector/man-professional-business-casual-young-avatar-icon-illustration_1277826-622.jpg?w=740","post_image":"https://wallpapercave.com/uwp/uwp4596879.png","caption":"Exploring the beauty of nature! ðŸŒ¿âœ¨","likes":120,"comments":[{"user":"Jane Smith","comment":"Absolutely stunning! â¤ï¸"},{"user":"Mike Johnson","comment":"Where was this taken? Looks amazing!"}]},{"name":"Alice Brown","profile_image":"https://img.freepik.com/premium-vector/default-female-user-profile-icon-vector-illustration_276184-169.jpg?w=740","post_image":"https://wallpapercave.com/wp/wp14900124.webp","caption":"City lights and vibes ðŸŒ†âœ¨","likes":245,"comments":[{"user":"David Clark","comment":"Amazing shot!"},{"user":"Sophia Davis","comment":"Love this view!"}]},{"name":"Chris Green","profile_image":"https://img.freepik.com/premium-vector/default-male-user-profile-icon-vector-illustration_276184-196.jpg?w=740","post_image":"https://wallpapercave.com/wp/wp1836202.jpg","caption":"Waves crashing into the shore ðŸŒŠâœ¨","likes":89,"comments":[{"user":"Megan Lee","comment":"Such a peaceful view!"},{"user":"Tom Wilson","comment":"I need a vacation now!"}]},{"name":"Sophia Carter","profile_image":"https://img.freepik.com/premium-vector/default-female-avatar-profile-icon-social-media-user-portrait_276184-418.jpg?w=740","post_image":"https://wallpapercave.com/wp/wp4896562.jpg","caption":"Adventures in the mountains â›°ï¸âœ¨","likes":180,"comments":[{"user":"Emma Collins","comment":"Mountains are calling! â›°ï¸"},{"user":"Ryan Miller","comment":"This looks like an amazing hike!"}]},{"name":"David Wright","profile_image":"https://img.freepik.com/premium-vector/avatar-man-casual-clothes_24877-826.jpg?w=740","post_image":"https://wallpapercave.com/wp/wp7293961.jpg","caption":"Sunset hues ðŸŒ…âœ¨","likes":200,"comments":[{"user":"Laura Bennett","comment":"This sunset is mesmerizing!"},{"user":"Oliver Scott","comment":"Golden hour at its best!"}]},{"name":"Lily Adams","profile_image":"https://img.freepik.com/premium-vector/female-avatar-profile-icon-round-woman-face-vector-illustration_276184-413.jpg?w=740","post_image":"https://wallpapercave.com/wp/wp8038417.jpg","caption":"Serene moments by the lake ðŸŒ…âœ¨","likes":155,"comments":[{"user":"Jake Evans","comment":"Such tranquility!"},{"user":"Anna Roberts","comment":"Lake views are the best!"}]},{"name":"Emily Taylor","profile_image":"https://img.freepik.com/premium-vector/default-female-user-profile-icon-social-media_276184-418.jpg?w=740","post_image":"https://wallpapercave.com/wp/wp4720190.jpg","caption":"Blossoms and smiles ðŸŒ¸âœ¨","likes":312,"comments":[{"user":"Michael Brown","comment":"Lovely picture!"},{"user":"Sarah Williams","comment":"Nature at its best!"}]},{"name":"Jake Moore","profile_image":"https://img.freepik.com/premium-vector/avatar-male-businessman_24877-627.jpg?w=740","post_image":"https://wallpapercave.com/wp/wp7293965.jpg","caption":"Calm seas and endless skies ðŸŒŠâœ¨","likes":87,"comments":[{"user":"Hannah Ross","comment":"Looks so peaceful!"},{"user":"Liam Morgan","comment":"I could stare at this forever!"}]},{"name":"Sophia Carter","profile_image":"https://img.freepik.com/premium-vector/default-female-avatar-profile-icon-round-woman-face-vector-illustration_276184-413.jpg?w=740","post_image":"https://wallpapercave.com/wp/wp6299652.jpg","caption":"Misty mornings in the hills ðŸŒ„âœ¨","likes":178,"comments":[{"user":"Andrew Gray","comment":"Hills and chills!"},{"user":"Natalie Hughes","comment":"This is so dreamy!"}]},{"name":"John Doe","profile_image":"https://img.freepik.com/premium-vector/man-professional-business-casual-young-avatar-icon-illustration_1277826-622.jpg?w=740","post_image":"https://wallpapercave.com/uwp/uwp4596879.png","caption":"Exploring the beauty of nature! ðŸŒ¿âœ¨","likes":120,"comments":[{"user":"Jane Smith","comment":"Absolutely stunning! â¤ï¸"},{"user":"Mike Johnson","comment":"Where was this taken? Looks amazing!"}]},{"name":"Alice Brown","profile_image":"https://img.freepik.com/premium-vector/default-female-user-profile-icon-vector-illustration_276184-169.jpg?w=740","post_image":"https://wallpapercave.com/wp/wp14900124.webp","caption":"City lights and vibes ðŸŒ†âœ¨","likes":245,"comments":[{"user":"David Clark","comment":"Amazing shot!"},{"user":"Sophia Davis","comment":"Love this view!"}]},{"name":"Chris Green","profile_image":"https://img.freepik.com/premium-vector/default-male-user-profile-icon-vector-illustration_276184-196.jpg?w=740","post_image":"https://wallpapercave.com/wp/wp1836202.jpg","caption":"Waves crashing into the shore ðŸŒŠâœ¨","likes":89,"comments":[{"user":"Megan Lee","comment":"Such a peaceful view!"},{"user":"Tom Wilson","comment":"I need a vacation now!"}]},{"name":"Sophia Carter","profile_image":"https://img.freepik.com/premium-vector/default-female-avatar-profile-icon-social-media-user-portrait_276184-418.jpg?w=740","post_image":"https://wallpapercave.com/wp/wp4896562.jpg","caption":"Adventures in the mountains â›°ï¸âœ¨","likes":180,"comments":[{"user":"Emma Collins","comment":"Mountains are calling! â›°ï¸"},{"user":"Ryan Miller","comment":"This looks like an amazing hike!"}]},{"name":"David Wright","profile_image":"https://img.freepik.com/premium-vector/avatar-man-casual-clothes_24877-826.jpg?w=740","post_image":"https://wallpapercave.com/wp/wp7293961.jpg","caption":"Sunset hues ðŸŒ…âœ¨","likes":200,"comments":[{"user":"Laura Bennett","comment":"This sunset is mesmerizing!"},{"user":"Oliver Scott","comment":"Golden hour at its best!"}]},{"name":"Lily Adams","profile_image":"https://img.freepik.com/premium-vector/female-avatar-profile-icon-round-woman-face-vector-illustration_276184-413.jpg?w=740","post_image":"https://wallpapercave.com/wp/wp8038417.jpg","caption":"Serene moments by the lake ðŸŒ…âœ¨","likes":155,"comments":[{"user":"Jake Evans","comment":"Such tranquility!"},{"user":"Anna Roberts","comment":"Lake views are the best!"}]},{"name":"Emily Taylor","profile_image":"https://img.freepik.com/premium-vector/default-female-user-profile-icon-social-media_276184-418.jpg?w=740","post_image":"https://wallpapercave.com/wp/wp4720190.jpg","caption":"Blossoms and smiles ðŸŒ¸âœ¨","likes":312,"comments":[{"user":"Michael Brown","comment":"Lovely picture!"},{"user":"Sarah Williams","comment":"Nature at its best!"}]},{"name":"Jake Moore","profile_image":"https://img.freepik.com/premium-vector/avatar-male-businessman_24877-627.jpg?w=740","post_image":"https://wallpapercave.com/wp/wp7293965.jpg","caption":"Calm seas and endless skies ðŸŒŠâœ¨","likes":87,"comments":[{"user":"Hannah Ross","comment":"Looks so peaceful!"},{"user":"Liam Morgan","comment":"I could stare at this forever!"}]},{"name":"Sophia Carter","profile_image":"https://img.freepik.com/premium-vector/default-female-avatar-profile-icon-round-woman-face-vector-illustration_276184-413.jpg?w=740","post_image":"https://wallpapercave.com/wp/wp6299652.jpg","caption":"Misty mornings in the hills ðŸŒ„âœ¨","likes":178,"comments":[{"user":"Andrew Gray","comment":"Hills and chills!"},{"user":"Natalie Hughes","comment":"This is so dreamy!"}]},{"name":"John Doe","profile_image":"https://img.freepik.com/premium-vector/man-professional-business-casual-young-avatar-icon-illustration_1277826-622.jpg?w=740","post_image":"https://wallpapercave.com/uwp/uwp4596879.png","caption":"Exploring the beauty of nature! ðŸŒ¿âœ¨","likes":120,"comments":[{"user":"Jane Smith","comment":"Absolutely stunning! â¤ï¸"},{"user":"Mike Johnson","comment":"Where was this taken? Looks amazing!"}]},{"name":"Alice Brown","profile_image":"https://img.freepik.com/premium-vector/default-female-user-profile-icon-vector-illustration_276184-169.jpg?w=740","post_image":"https://wallpapercave.com/wp/wp14900124.webp","caption":"City lights and vibes ðŸŒ†âœ¨","likes":245,"comments":[{"user":"David Clark","comment":"Amazing shot!"},{"user":"Sophia Davis","comment":"Love this view!"}]},{"name":"Chris Green","profile_image":"https://img.freepik.com/premium-vector/default-male-user-profile-icon-vector-illustration_276184-196.jpg?w=740","post_image":"https://wallpapercave.com/wp/wp1836202.jpg","caption":"Waves crashing into the shore ðŸŒŠâœ¨","likes":89,"comments":[{"user":"Megan Lee","comment":"Such a peaceful view!"},{"user":"Tom Wilson","comment":"I need a vacation now!"}]},{"name":"Sophia Carter","profile_image":"https://img.freepik.com/premium-vector/default-female-avatar-profile-icon-social-media-user-portrait_276184-418.jpg?w=740","post_image":"https://wallpapercave.com/wp/wp4896562.jpg","caption":"Adventures in the mountains â›°ï¸âœ¨","likes":180,"comments":[{"user":"Emma Collins","comment":"Mountains are calling! â›°ï¸"},{"user":"Ryan Miller","comment":"This looks like an amazing hike!"}]},{"name":"David Wright","profile_image":"https://img.freepik.com/premium-vector/avatar-man-casual-clothes_24877-826.jpg?w=740","post_image":"https://wallpapercave.com/wp/wp7293961.jpg","caption":"Sunset hues ðŸŒ…âœ¨","likes":200,"comments":[{"user":"Laura Bennett","comment":"This sunset is mesmerizing!"},{"user":"Oliver Scott","comment":"Golden hour at its best!"}]},{"name":"Lily Adams","profile_image":"https://img.freepik.com/premium-vector/female-avatar-profile-icon-round-woman-face-vector-illustration_276184-413.jpg?w=740","post_image":"https://wallpapercave.com/wp/wp8038417.jpg","caption":"Serene moments by the lake ðŸŒ…âœ¨","likes":155,"comments":[{"user":"Jake Evans","comment":"Such tranquility!"},{"user":"Anna Roberts","comment":"Lake views are the best!"}]},{"name":"Emily Taylor","profile_image":"https://img.freepik.com/premium-vector/default-female-user-profile-icon-social-media_276184-418.jpg?w=740","post_image":"https://wallpapercave.com/wp/wp4720190.jpg","caption":"Blossoms and smiles ðŸŒ¸âœ¨","likes":312,"comments":[{"user":"Michael Brown","comment":"Lovely picture!"},{"user":"Sarah Williams","comment":"Nature at its best!"}]},{"name":"Jake Moore","profile_image":"https://img.freepik.com/premium-vector/avatar-male-businessman_24877-627.jpg?w=740","post_image":"https://wallpapercave.com/wp/wp7293965.jpg","caption":"Calm seas and endless skies ðŸŒŠâœ¨","likes":87,"comments":[{"user":"Hannah Ross","comment":"Looks so peaceful!"},{"user":"Liam Morgan","comment":"I could stare at this forever!"}]},{"name":"Sophia Carter","profile_image":"https://img.freepik.com/premium-vector/default-female-avatar-profile-icon-round-woman-face-vector-illustration_276184-413.jpg?w=740","post_image":"https://wallpapercave.com/wp/wp6299652.jpg","caption":"Misty mornings in the hills ðŸŒ„âœ¨","likes":178,"comments":[{"user":"Andrew Gray","comment":"Hills and chills!"},{"user":"Natalie Hughes","comment":"This is so dreamy!"}]}]
