//
//  HomeViewController.swift
//  TikTokClone
//
//  Created by Imen on 13/09/2022.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var mTableView: UITableView!
    
    // MARK: - Variables
    var videos : [HomeVideoStruct] = []
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videos = VideoCacheManager.shared.fetchAllVideos()
        print("videeeos = \(videos)")
        
        if(videos.count == 0){
            saveTestVideosToCache()
        }
        
        mTableView.isPagingEnabled = true
        mTableView.contentInsetAdjustmentBehavior = .never
        mTableView.showsVerticalScrollIndicator = false
        mTableView.separatorStyle = .none
        mTableView.delegate = self
        mTableView.dataSource = self
        mTableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTVCell")


    }
    
    func saveTestVideosToCache(){
        let homeVideo1 = HomeVideoStruct(videoName: "Magic System - Feel the magic in the air",
                                         videoURL: "video1",
                                         videoTags: "@Magic System",
                                         numberLike: 2764,
                                         numberComment: 2343,
                                         numberShare: 2334)
        let homeVideo2 = HomeVideoStruct(videoName: "Michael Jackson - They don't care about us",
                                         videoURL: "video2",
                                         videoTags: "@Michael Jackson",
                                         numberLike: 7879,
                                         numberComment: 5673,
                                         numberShare: 8879)
        let homeVideo3 = HomeVideoStruct(videoName: "Shakira - Hips don't lie",
                                         videoURL: "video3",
                                         videoTags: "@Shakira",
                                         numberLike: 4589,
                                         numberComment: 4554,
                                         numberShare: 8878)
        
        VideoCacheManager.shared.addVideoToCache(video: homeVideo1)
        VideoCacheManager.shared.addVideoToCache(video: homeVideo2)
        VideoCacheManager.shared.addVideoToCache(video: homeVideo3)
        
        videos = VideoCacheManager.shared.fetchAllVideos()
        mTableView.reloadData()
    }
}

// MARK: - TableView Extensions
extension HomeViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTVCell", for: indexPath) as! HomeTableViewCell
        cell.selectionStyle = .none
        let currentVideo = videos[indexPath.row]
        
        cell.musicLabel.text = currentVideo.videoName
        cell.tagBtn.setTitle(currentVideo.videoTags, for: .normal)
        cell.nbCommentsLabel.text = "\(currentVideo.numberComment)"
        cell.nbLikesLabel.text = "\(currentVideo.numberLike)"
        cell.nbShareLabel.text = "\(currentVideo.numberShare)"
        
        cell.videoURL = currentVideo.videoURL
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cellHTV : HomeTableViewCell = cell as! HomeTableViewCell
        cellHTV.musicLabel.restartLabel()
        cellHTV.startPlayingVideo()
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cellHTV : HomeTableViewCell = cell as! HomeTableViewCell
        cellHTV.pauseVideo()
    }
    
}
