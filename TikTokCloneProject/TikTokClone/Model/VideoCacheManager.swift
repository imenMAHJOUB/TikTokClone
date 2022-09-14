//
//  VideoCacheManager.swift
//  TikTokClone
//
//  Created by Imen on 14/09/2022.
//

import UIKit
import CoreData

class VideoCacheManager: NSObject {

    // VideoCacheManager is a singleton
    static let shared: VideoCacheManager = {
        return VideoCacheManager.init()
    }()
    
    // MARK: - Variables
    
    
    // MARK: - Initializer
    private override init() {
        super.init()
        
    }
    
    // MARK: - Write Data
    func addVideoToCache(video : HomeVideoStruct) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "HomeVideo", in: context)!
        let homeVideo = NSManagedObject(entity: entity, insertInto: context)
        
        homeVideo.setValue(video.videoName, forKey: "videoName")
        homeVideo.setValue(video.videoURL, forKey: "videoURL")
        homeVideo.setValue(video.videoTags, forKey: "videoTags")
        homeVideo.setValue(video.numberLike, forKey: "numberLike")
        homeVideo.setValue(video.numberShare, forKey: "numberShare")
        homeVideo.setValue(video.numberComment, forKey: "numberComment")

        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    
    // MARK: - Read Data
    func fetchAllVideos() -> [HomeVideoStruct] {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "HomeVideo")
        
        do {
            let videos = try managedContext.fetch(fetchRequest)
            var homeVideos : [HomeVideoStruct] = []
            
            for video in videos {
                homeVideos.append(HomeVideoStruct(videoName: video.value(forKey: "videoName") as! String,
                                                  videoURL: video.value(forKey: "videoURL") as! String,
                                                  videoTags: video.value(forKey: "videoTags") as! String,
                                                  numberLike: video.value(forKey: "numberLike") as! Int,
                                                  numberComment: video.value(forKey: "numberComment") as! Int,
                                                  numberShare: video.value(forKey: "numberShare") as! Int)
                )
            }
            
            return homeVideos
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
        
    }
    
}
