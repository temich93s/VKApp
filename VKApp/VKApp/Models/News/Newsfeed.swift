// Newsfeed.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Новость пользователя
final class Newsfeed: Decodable {
    // let type: PostTypeEnum //
    var sourceID = 0
    var date = 0 //
    let photos: Photos? //
    var text: String? //
    // let attachments: [Attachment]? //
    let likes: PurpleLikes? //
    let views: Views? //

    enum CodingKeys: String, CodingKey {
        // case type
        case sourceID = "source_id"
        case date
        case photos
        // case postType = "post_type"
        case text
        // case attachments
        case likes
        case views
    }
}

///
enum PostTypeEnum: String, Codable {
    case photo
    case post
    case wallPhoto = "wall_photo"
}

/// количество просмотров
struct Views: Codable {
    let count: Int
}

///
struct PurpleLikes: Codable {
    let count: Int

    enum CodingKeys: String, CodingKey {
        case count
    }
}

/*

 // MARK: - Attachment

 struct Attachment: Codable {
     let type: AttachmentType
     let photo: Phto?
 }

 // MARK: - Photo
 */

///
struct Photos: Codable {
    let items: [PhotosItem]
}

///
struct PhotosItem: Codable {
    let sizes: [Size]

    enum CodingKeys: String, CodingKey {
        case sizes
    }
}

///
struct Size: Codable {
    let url: String
    enum CodingKeys: String, CodingKey {
        case url
    }
}

/*

 ///
 enum AttachmentType: String, Codable {
     case photo
     case video
 }

 // MARK: - CategoryAction

 struct CategoryAction: Codable {
     let action: Action
     let name: String
 }

 // MARK: - Action

 struct Action: Codable {
     let target, type, url: String
 }

 // MARK: - Comments

 struct Comments: Codable {
     let canPost, count: Int

     enum CodingKeys: String, CodingKey {
         case canPost = "can_post"
         case count
     }
 }

 // MARK: - Donut

 struct Donut: Codable {
     let isDonut: Bool

     enum CodingKeys: String, CodingKey {
         case isDonut = "is_donut"
     }
 }

 // MARK: - PurpleLikes
 */

/*
 // MARK: - Photos

 struct Photos: Codable {
     let count: Int
     let items: [PhotosItem]
 }

 // MARK: - PhotosItem

 struct PhotosItem: Codable {
     let albumID, date, id, ownerID: Int
     let accessKey: String
     let canComment: Int
     let sizes: [Size]
     let text: String
     let hasTags: Bool
     let likes: FluffyLikes
     let comments: Views
     let reposts: Reposts
     let canRepost: Int
     let userID, postID: Int?

     enum CodingKeys: String, CodingKey {
         case albumID = "album_id"
         case date, id
         case ownerID = "owner_id"
         case accessKey = "access_key"
         case canComment = "can_comment"
         case sizes, text
         case hasTags = "has_tags"
         case likes, comments, reposts
         case canRepost = "can_repost"
         case userID = "user_id"
         case postID = "post_id"
     }
 }
 */

/*
 // MARK: - FluffyLikes

 struct FluffyLikes: Codable {
     let count, userLikes: Int

     enum CodingKeys: String, CodingKey {
         case count
         case userLikes = "user_likes"
     }
 }

 // MARK: - Reposts

 struct Reposts: Codable {
     let count, userReposted: Int

     enum CodingKeys: String, CodingKey {
         case count
         case userReposted = "user_reposted"
     }
 }

 // MARK: - PostSource

 struct PostSource: Codable {
     let type: PostSourceType
     let platform: String?
 }

 enum PostSourceType: String, Codable {
     case api
     case vk
 }

 // MARK: - Profile

 struct Profile: Codable {
     let id, sex: Int
     let photo50, photo100: String
     let onlineInfo: OnlineInfo
     let online: Int
     let deactivated: String?
     let firstName, lastName: String
     let screenName: String?
     let canAccessClosed, isClosed: Bool?

     enum CodingKeys: String, CodingKey {
         case id, sex
         case photo50 = "photo_50"
         case photo100 = "photo_100"
         case onlineInfo = "online_info"
         case online, deactivated
         case firstName = "first_name"
         case lastName = "last_name"
         case screenName = "screen_name"
         case canAccessClosed = "can_access_closed"
         case isClosed = "is_closed"
     }
 }

 // MARK: - OnlineInfo

 struct OnlineInfo: Codable {
     let visible, isOnline, isMobile: Bool
     let lastSeen, appID: Int?

     enum CodingKeys: String, CodingKey {
         case visible
         case isOnline = "is_online"
         case isMobile = "is_mobile"
         case lastSeen = "last_seen"
         case appID = "app_id"
     }
 }

 */
