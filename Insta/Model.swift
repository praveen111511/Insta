//
//  Model.swift
//  Insta
//
//  Created by Toqsoft on 31/12/24.
//

import Foundation
//MARK Feeds
struct Post: Codable {
    let name: String
    let profileImage: String
    let postImage: String
    let caption: String
    let likes: Int
    let comments: [Comment]
    
    enum CodingKeys: String, CodingKey {
        case name
        case profileImage = "profile_image"
        case postImage = "post_image"
        case caption
        case likes
        case comments
    }
}
//MARK Story
struct Comment: Codable {
    let user: String
    let comment: String
}
struct User: Codable {
    let userImage: String
    let userName: String
}


//MARK Notification

struct MessagesData: Codable {
    let data: TimePeriods
}

struct TimePeriods: Codable {
    let today: [UserMessage]
    let yesterday: [UserMessage]
    let last7Days: [UserMessage]
    let last30Days: [UserMessage]
}

struct UserMessage: Codable {
    let userImage: String
    let userName: String
    let message: String
}

//MARK Reels
struct Reel: Codable {
    let username: String
    let userImage: String
    let videoURL: String
}
