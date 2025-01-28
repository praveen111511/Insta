//
//  ReelsVC.swift
//  Insta
//
//  Created by Toqsoft on 17/01/25.
//

import UIKit
import AVFoundation
import Foundation



class ReelsVC: UIViewController {
    var getData: [Reel]?
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register( UINib(nibName: "ReelsCVC", bundle: nil),  forCellWithReuseIdentifier: "ReelsCVC")
        // Ensure the collection view flow layout is set correctly
           if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
               layout.scrollDirection = .vertical
               layout.minimumLineSpacing = 0 // No spacing between cells
               layout.minimumInteritemSpacing = 0 // Make sure there's no spacing
           }
           
           collectionView.isPagingEnabled = true // Enable paging

           apiCall()
    }
    func apiCall(){
        let url = URL(string: "https://mocki.io/v1/4577cb44-77a2-4dbf-814f-da54ca9ead3b")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { data, response, error in
            let decoder = JSONDecoder()
            do{
                let result = try decoder.decode([Reel].self, from: data!)
                DispatchQueue.main.async {
                    self.getData = result
                    print("Response ----->\(result)")
                    self.collectionView.reloadData()
                }
            }catch{
                
            }
        }.resume()
    }
    

}
extension ReelsVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReelsCVC", for: indexPath)as! ReelsCVC
        if let reel = getData?[indexPath.row] {
            cell.configure(with: reel)
        }
        return cell
    }
    // UICollectionViewDelegateFlowLayout method to define the cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Get the screen width and height for the current device
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        
        // Return the size that fills the screen
        return CGSize(width: width, height: height)
    }
    
    
    
    //new data added
    
    func apicCall(){
        let url = URL(string: "https://mocki.io/v1/4577cb44-77a2-4dbf-814f-da54ca9ead3b")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { data, response, error in
            let decoder = JSONDecoder()
            do{
                let result = try decoder.decode([Reel].self, from: data!)
                DispatchQueue.main.async {
                    self.getData = result
                    print("Response ----->\(result)")
                    self.collectionView.reloadData()
                }
            }catch{
                
            }
        }.resume()
    }
    

    
    
}


// Reels api json
//
//[
//    {
//        "username": "JohnDoe",
//        "userImage": "https://images.unsplash.com/photo-1517423440428-a5a00ad493e8",
//        "videoURL": "https://player.vimeo.com/external/457001000.sd.mp4?s=0c3dd86db3c37041cd91aa5c7dbd0b379f871243"
//    },
//    {
//        "username": "JaneSmith",
//        "userImage": "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d",
//        "videoURL": "https://player.vimeo.com/external/396469406.sd.mp4?s=6a1edb4c52b8e4d9c4f1a6895c77c19ef8a73a2f"
//    },
//    {
//        "username": "MikeBrown",
//        "userImage": "https://images.unsplash.com/photo-1544005313-94ddf0286df2",
//        "videoURL": "https://player.vimeo.com/external/457000464.sd.mp4?s=87c2d0900b6ed169a21c8c22dfcd6f9ff555a330"
//    },
//    {
//        "username": "EmmaTaylor",
//        "userImage": "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde",
//        "videoURL": "https://player.vimeo.com/external/465184067.sd.mp4?s=2c5bcbd4609e5cc31db3fc9a35646e2bda80c8ed"
//    },
//    {
//        "username": "ChrisEvans",
//        "userImage": "https://images.unsplash.com/photo-1517841905240-472988babdf9",
//        "videoURL": "https://player.vimeo.com/external/395587393.sd.mp4?s=02f83dc720312303f1ad27e4db2c510ab0f5b36f"
//    },
//    {
//        "username": "SophiaClark",
//        "userImage": "https://images.unsplash.com/photo-1542206395-9feb3edaa68f",
//        "videoURL": "https://player.vimeo.com/external/410810979.sd.mp4?s=de758b43cfb3c5d4e5b49e9ea5d48cdd4b8c474b"
//    },
//    {
//        "username": "LiamJohnson",
//        "userImage": "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d",
//        "videoURL": "https://player.vimeo.com/external/418003634.sd.mp4?s=ea0300ecae6ec8f315a9c12b78668c61cf8d040e"
//    },
//    {
//        "username": "OliviaMartinez",
//        "userImage": "https://images.unsplash.com/photo-1517423440428-a5a00ad493e8",
//        "videoURL": "https://player.vimeo.com/external/416769634.sd.mp4?s=87c2d0900b6ed169a21c8c22dfcd6f9ff555a330"
//    },
//    {
//        "username": "NoahWilliams",
//        "userImage": "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde",
//        "videoURL": "https://player.vimeo.com/external/465184067.sd.mp4?s=2c5bcbd4609e5cc31db3fc9a35646e2bda80c8ed"
//    },
//    {
//        "username": "AvaGarcia",
//        "userImage": "https://images.unsplash.com/photo-1542206395-9feb3edaa68f",
//        "videoURL": "https://player.vimeo.com/external/395587393.sd.mp4?s=02f83dc720312303f1ad27e4db2c510ab0f5b36f"
//    }
//]
