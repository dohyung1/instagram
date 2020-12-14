//
//  Models.swift
//  instagram
//
//  Created by Administrator on 12/14/20.
//

import Foundation

enum Gender{
    case male, female, other
}

struct User{
    let username: String
    let bio:String
    let name: (first: String, last: String)
    let birthDate: Date
    let gender: Gender
    let counts: UserCount
    let joinDate: Date
}

struct UserCount{
    let followers:Int
    let following:Int
    let posts: Int
}

public enum UserPostType{
    case photo,video
}

public struct UserPost{
    let identifier:String
    let postType:UserPostType
    let thumbnailImage: URL
    let caption:String?
    let likes:[PostLike]
    let postURL:URL //either video URL or full resolution photo
    let comments: [PostComment]
    let createdDate:Date
    let taggedUsers: [String]
}

struct PostLike{
    let username:String
    let postIdentifier:String
    
}

struct CommentLike{
    let username:String
    let commentIdentifier:String
    
}

struct PostComment{
    let username: String
    let text:String
    let createdDate:Date
    let likes:[CommentLike]
}
