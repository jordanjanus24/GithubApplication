//
//  User.swift
//  GithubApplication
//
//  Created by Janus Jordan on 2/4/23.
//

import Foundation

struct User: Hashable {
    
    let login: String
    let id: Int64
    let nodeId: String
    let avatarUrl: String
    let gravatarId: String
    let url: String
    let htmlUrl: String
    let followersUrl: String
    let followingUrl: String
    let gistsUrl: String
    let starredUrl: String
    let subscriptionsUrl: String
    let organizationsUrl: String
    let reposUrl: String
    let eventsUrl: String
    let receivedEventsUrl: String
    let type: String
    let siteAdmin: Bool
    let note: String
    let name: String
    let company: String
    let blog: String
    let location: String
    let email: String
    let hireable: String
    let bio: String
    let twitterUsername: String
    let publicRepos: Int
    let publicGists: Int
    let followers: Int
    let following: Int
    
}
