import UIKit
import AVFoundation

class ReelsCVC: UICollectionViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var videoPlayerView: UIView!
    
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userImageView.layer.cornerRadius = 25
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // Stop the video when the cell is reused
        player?.pause()
        playerLayer?.removeFromSuperlayer()
        player = nil
        playerLayer = nil
    }

    func configure(with reel: Reel) {
        // Set username
        usernameLabel.text = reel.username
        
        // Set user image
        if let url = URL(string: reel.userImage) {
            // Load image asynchronously
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.userImageView.image = UIImage(data: data)
                    }
                }
            }
        }
        
        // Set up the video player
        if let url = URL(string: reel.videoURL) {
            // Remove any existing player layer
            playerLayer?.removeFromSuperlayer()
            
            player = AVPlayer(url: url)
            playerLayer = AVPlayerLayer(player: player)
            playerLayer?.frame = videoPlayerView.bounds
            playerLayer?.videoGravity = .resizeAspectFill
            videoPlayerView.layer.addSublayer(playerLayer!)
            player?.play()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Ensure the player layer resizes correctly with the cell's bounds
        playerLayer?.frame = videoPlayerView.bounds
    }
}
