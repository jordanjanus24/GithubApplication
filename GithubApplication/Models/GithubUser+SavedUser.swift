//
//  GithubUser+SavedUser.swift
//  GithubApplication
//
//  Created by Janus Jordan on 2/4/23.
//

import Foundation

extension GithubUserDetails {
    mutating func mapToSavedUser(savedUser: SavedUser) {
        savedUser.login = self.login
        savedUser.id = self.id
        savedUser.nodeId = self.nodeId
        savedUser.avatarUrl = self.avatarUrl
        savedUser.gravatarId = self.gravatarId
        savedUser.url = self.url
        savedUser.htmlUrl = self.htmlUrl
        savedUser.followersUrl = self.followersUrl
        savedUser.gistsUrl = self.gistsUrl
        savedUser.starredUrl = self.starredUrl
        savedUser.subscriptionsUrl = self.subscriptionsUrl
        savedUser.organizationsUrl = self.organizationsUrl
        savedUser.reposUrl = self.reposUrl
        savedUser.eventsUrl = self.eventsUrl
        savedUser.receivedEventsUrl = self.receivedEventsUrl
        savedUser.type = self.type
        savedUser.siteAdmin = self.siteAdmin
        savedUser.name = self.name
        savedUser.company = self.company
        savedUser.blog = self.blog
        savedUser.location = self.location
        savedUser.email = self.email
        savedUser.hireable = self.hireable
        savedUser.bio = self.bio
        savedUser.twitterUsername = self.twitterUsername
        savedUser.publicRepos = self.publicRepos
        savedUser.publicGists = self.publicGists
        savedUser.followers = self.followers
        savedUser.following = self.following
    }
    func toUser() -> User {
        let user: User = User(
            login: self.login ,
            id: self.id,
            nodeId: self.nodeId,
            avatarUrl: self.avatarUrl,
            gravatarId: self.gravatarId,
            url: self.url,
            htmlUrl: self.htmlUrl,
            followersUrl: self.followersUrl,
            followingUrl: self.followingUrl,
            gistsUrl: self.gistsUrl,
            starredUrl: self.starredUrl,
            subscriptionsUrl: self.subscriptionsUrl,
            organizationsUrl: self.organizationsUrl,
            reposUrl: self.reposUrl,
            eventsUrl: self.eventsUrl,
            receivedEventsUrl: self.receivedEventsUrl,
            type: self.type,
            siteAdmin: self.siteAdmin,
            note: "",
            name: self.name ?? "",
            company: self.company ?? "",
            blog: self.blog ?? "",
            location: self.location ?? "",
            email: self.email ?? "",
            hireable: self.hireable ?? "",
            bio: self.bio ?? "",
            twitterUsername: self.twitterUsername ?? "",
            publicRepos: self.publicRepos,
            publicGists: self.publicGists,
            followers: self.followers,
            following: self.following,
            seen: false
        )
        return user
    }
}

extension GithubUser {
    mutating func mapToSavedUser(savedUser: SavedUser) {
        savedUser.login = self.login
        savedUser.id = self.id
        savedUser.nodeId = self.nodeId
        savedUser.avatarUrl = self.avatarUrl
        savedUser.gravatarId = self.gravatarId
        savedUser.url = self.url
        savedUser.htmlUrl = self.htmlUrl
        savedUser.followersUrl = self.followersUrl
        savedUser.gistsUrl = self.gistsUrl
        savedUser.starredUrl = self.starredUrl
        savedUser.subscriptionsUrl = self.subscriptionsUrl
        savedUser.organizationsUrl = self.organizationsUrl
        savedUser.reposUrl = self.reposUrl
        savedUser.eventsUrl = self.eventsUrl
        savedUser.receivedEventsUrl = self.receivedEventsUrl
        savedUser.type = self.type
        savedUser.siteAdmin = self.siteAdmin
    }
    func toUser() -> User {
        let user: User = User(
            login: self.login ,
            id: self.id,
            nodeId: self.nodeId,
            avatarUrl: self.avatarUrl,
            gravatarId: self.gravatarId,
            url: self.url,
            htmlUrl: self.htmlUrl,
            followersUrl: self.followersUrl,
            followingUrl: self.followingUrl,
            gistsUrl: self.gistsUrl,
            starredUrl: self.starredUrl,
            subscriptionsUrl: self.subscriptionsUrl,
            organizationsUrl: self.organizationsUrl,
            reposUrl: self.reposUrl,
            eventsUrl: self.eventsUrl,
            receivedEventsUrl: self.receivedEventsUrl,
            type: self.type,
            siteAdmin: self.siteAdmin,
            note: "",
            name: "",
            company: "",
            blog: "",
            location: "",
            email: "",
            hireable: "",
            bio: "",
            twitterUsername: "",
            publicRepos: 0,
            publicGists: 0,
            followers: 0,
            following: 0,
            seen: false
        )
        return user
    }
}

extension SavedUser {
    func toGithubUser() -> GithubUser {
        let githubUser: GithubUser = GithubUser(
            login: self.login ?? "",
            id: self.id,
            nodeId: self.nodeId ?? "",
            avatarUrl: self.avatarUrl ?? "",
            gravatarId: self.gravatarId ?? "",
            url: self.url ?? "",
            htmlUrl: self.htmlUrl ?? "",
            followersUrl: self.followersUrl ?? "",
            followingUrl: self.followingUrl ?? "",
            gistsUrl: self.gistsUrl ?? "",
            starredUrl: self.starredUrl ?? "",
            subscriptionsUrl: self.subscriptionsUrl ?? "",
            organizationsUrl: self.organizationsUrl ?? "",
            reposUrl: self.reposUrl ?? "",
            eventsUrl: self.eventsUrl ?? "",
            receivedEventsUrl: self.receivedEventsUrl ?? "",
            type: self.type ?? "",
            siteAdmin: self.siteAdmin
        )
        return githubUser
    }
    
    func toGithubUserDetails() -> GithubUserDetails {
        let githubUser: GithubUserDetails = GithubUserDetails(
            login: self.login ?? "",
            id: self.id,
            nodeId: self.nodeId ?? "",
            avatarUrl: self.avatarUrl ?? "",
            gravatarId: self.gravatarId ?? "",
            url: self.url ?? "",
            htmlUrl: self.htmlUrl ?? "",
            followersUrl: self.followersUrl ?? "",
            followingUrl: self.followingUrl ?? "",
            gistsUrl: self.gistsUrl ?? "",
            starredUrl: self.starredUrl ?? "",
            subscriptionsUrl: self.subscriptionsUrl ?? "",
            organizationsUrl: self.organizationsUrl ?? "",
            reposUrl: self.reposUrl ?? "",
            eventsUrl: self.eventsUrl ?? "",
            receivedEventsUrl: self.receivedEventsUrl ?? "",
            type: self.type ?? "",
            siteAdmin: self.siteAdmin,
            name: self.name ?? "",
            company: self.company ?? "",
            blog: self.blog ?? "",
            location: self.location ?? "",
            email: self.email ?? "",
            hireable: self.hireable ?? "",
            bio: self.bio ?? "",
            twitterUsername: self.twitterUsername ?? "",
            publicRepos: self.publicRepos,
            publicGists: self.publicGists,
            followers: self.followers,
            following: self.following
        )
        return githubUser
    }
    func toUser() -> User {
        let user: User = User(
            login: self.login ?? "",
            id: self.id,
            nodeId: self.nodeId ?? "",
            avatarUrl: self.avatarUrl ?? "",
            gravatarId: self.gravatarId ?? "",
            url: self.url ?? "",
            htmlUrl: self.htmlUrl ?? "",
            followersUrl: self.followersUrl ?? "",
            followingUrl: self.followingUrl ?? "",
            gistsUrl: self.gistsUrl ?? "",
            starredUrl: self.starredUrl ?? "",
            subscriptionsUrl: self.subscriptionsUrl ?? "",
            organizationsUrl: self.organizationsUrl ?? "",
            reposUrl: self.reposUrl ?? "",
            eventsUrl: self.eventsUrl ?? "",
            receivedEventsUrl: self.receivedEventsUrl ?? "",
            type: self.type ?? "",
            siteAdmin: self.siteAdmin,
            note: "",
            name: self.name ?? "",
            company: self.company ?? "",
            blog: self.blog ?? "",
            location: self.location ?? "",
            email: self.email ?? "",
            hireable: self.hireable ?? "",
            bio: self.bio ?? "",
            twitterUsername: self.twitterUsername ?? "",
            publicRepos: self.publicRepos,
            publicGists: self.publicGists,
            followers: self.followers,
            following: self.following,
            seen: false
        )
        return user
    }
}
