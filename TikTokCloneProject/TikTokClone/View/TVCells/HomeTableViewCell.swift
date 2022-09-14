//
//  HomeTableViewCell.swift
//  TikTokClone
//
//  Created by Imen on 13/09/2022.
//

import UIKit
import MarqueeLabel
import ASPVideoPlayer

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mMusicBtn: UIButton!
    @IBOutlet weak var mShareBtn: UIButton!
    @IBOutlet weak var mCommentsBtn: UIButton!
    @IBOutlet weak var mLikesBtn: UIButton!
    @IBOutlet weak var mProfileBtn: UIButton!
    @IBOutlet weak var musicLabel: MarqueeLabel!
    @IBOutlet weak var nbLikesLabel: UILabel!
    @IBOutlet weak var nbCommentsLabel: UILabel!
    @IBOutlet weak var nbShareLabel: UILabel!
    @IBOutlet weak var tagBtn: UIButton!
    @IBOutlet weak var videoPlayerView: ASPVideoPlayer!

    
    var videoURL : String! {
        didSet{
            guard let path = Bundle.main.path(forResource: videoURL, ofType:"mp4") else {
                return
            }
            let url : URL = URL(fileURLWithPath: path)
            videoPlayerView.videoURLs = [url]
            videoPlayerView.videoPlayerControls.isHidden = true
        }
    }
    
    func startPlayingVideo(){
        videoPlayerView.videoPlayerControls.play()
    }
    
    func pauseVideo(){
        videoPlayerView.videoPlayerControls.pause()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
}
