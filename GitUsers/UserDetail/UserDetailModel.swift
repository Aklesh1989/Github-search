//
//  UserDetailModel.swift
//  GitUsers
//
//  Created by Aklesh on 13/09/22.
//

import Foundation

struct UserDetail:Codable {
    
    var name:String!
    var userID:Int!
    var imageUrl:String!
    var followers:Int!
    var following:Int!
    var publicRepos:Int!
    var followersUrl:String!
    var followingUrl:String!
    var email:String!




    enum CodingKeys: String, CodingKey {
        case login
        case id
        case avatar_url
        case followers
        case following
        case public_repos
        case followers_url
        case following_url
        case email


    }
    
    public func encode(to encoder: Encoder) throws {}
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey:.login )
        userID = try values.decode(Int.self, forKey: .id)
        imageUrl = try values.decode(String.self, forKey: .avatar_url)
        followers = try values.decode(Int.self, forKey: .followers)
        following = try values.decode(Int.self, forKey: .following)
        publicRepos = try values.decode(Int.self, forKey: .public_repos)
        followingUrl = try values.decode(String.self, forKey: .following_url)
        followersUrl = try values.decode(String.self, forKey: .followers_url)
        email = try values.decode(String?.self, forKey: .email)



    }
}


/*{
  "login": "octocat",
  "id": 1,
  "node_id": "MDQ6VXNlcjE=",
  "avatar_url": "https://github.com/images/error/octocat_happy.gif",
  "gravatar_id": "",
  "url": "https://api.github.com/users/octocat",
  "html_url": "https://github.com/octocat",
  "followers_url": "https://api.github.com/users/octocat/followers",
  "following_url": "https://api.github.com/users/octocat/following{/other_user}",
  "gists_url": "https://api.github.com/users/octocat/gists{/gist_id}",
  "starred_url": "https://api.github.com/users/octocat/starred{/owner}{/repo}",
  "subscriptions_url": "https://api.github.com/users/octocat/subscriptions",
  "organizations_url": "https://api.github.com/users/octocat/orgs",
  "repos_url": "https://api.github.com/users/octocat/repos",
  "events_url": "https://api.github.com/users/octocat/events{/privacy}",
  "received_events_url": "https://api.github.com/users/octocat/received_events",
  "type": "User",
  "site_admin": false,
  "name": "monalisa octocat",
  "company": "GitHub",
  "blog": "https://github.com/blog",
  "location": "San Francisco",
  "email": "octocat@github.com",
  "hireable": false,
  "bio": "There once was...",
  "twitter_username": "monatheoctocat",
  "public_repos": 2,
  "public_gists": 1,
  "followers": 20,
  "following": 0,
  "created_at": "2008-01-14T04:33:35Z",
  "updated_at": "2008-01-14T04:33:35Z"
}*/

