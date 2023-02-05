//
//  ModelsMock.swift
//  GithubApplicationTests
//
//  Created by Janus Jordan on 2/5/23.
//

@testable import GithubApplication
import Foundation

enum ModelsMock {
    enum DefaultUsers {
        static let user1 = GithubUser(
            login: "mojombo",
            id: 1,
            nodeId: "MDQ6VXNlcjE=",
            avatarUrl: "https://avatars.githubusercontent.com/u/1?v=4",
            gravatarId: "",
            url: "https://api.github.com/users/mojombo",
            htmlUrl: "https://github.com/mojombo",
            followersUrl: "https://api.github.com/users/mojombo/followers",
            followingUrl: "https://api.github.com/users/mojombo/following{/other_user}",
            gistsUrl: "https://api.github.com/users/mojombo/gists{/gist_id}",
            starredUrl: "https://api.github.com/users/mojombo/starred{/owner}{/repo}",
            subscriptionsUrl: "https://api.github.com/users/mojombo/subscriptions",
            organizationsUrl: "https://api.github.com/users/mojombo/orgs",
            reposUrl: "https://api.github.com/users/mojombo/repos",
            eventsUrl: "https://api.github.com/users/mojombo/events{/privacy}",
            receivedEventsUrl: "https://api.github.com/users/mojombo/received_events",
            type: "User",
            siteAdmin: false
        )
        static let user2 = GithubUser(
            login: "defunkt",
            id: 2,
            nodeId: "MDQ6VXNlcjE=",
            avatarUrl: "https://avatars.githubusercontent.com/u/2?v=4",
            gravatarId: "",
            url: "https://api.github.com/users/defunkt",
            htmlUrl: "https://github.com/defunkt",
            followersUrl: "https://api.github.com/users/defunkt/followers",
            followingUrl: "https://api.github.com/users/defunkt/following{/other_user}",
            gistsUrl: "https://api.github.com/users/defunkt/gists{/gist_id}",
            starredUrl: "https://api.github.com/users/defunkt/starred{/owner}{/repo}",
            subscriptionsUrl: "https://api.github.com/users/defunkt/subscriptions",
            organizationsUrl: "https://api.github.com/users/defunkt/orgs",
            reposUrl: "https://api.github.com/users/defunkt/repos",
            eventsUrl: "https://api.github.com/users/defunkt/events{/privacy}",
            receivedEventsUrl: "https://api.github.com/users/defunkt/received_events",
            type: "User",
            siteAdmin: false
        )
        static let users = [user1, user2]
    }
    
    enum DefaultUserDetails {
        static let user = GithubUserDetails(
            login: "mojombo",
            id: 1,
            nodeId: "MDQ6VXNlcjE=",
            avatarUrl: "https://avatars.githubusercontent.com/u/1?v=4",
            gravatarId: "",
            url: "https://api.github.com/users/mojombo",
            htmlUrl: "https://github.com/mojombo",
            followersUrl: "https://api.github.com/users/mojombo/followers",
            followingUrl: "https://api.github.com/users/mojombo/following{/other_user}",
            gistsUrl: "https://api.github.com/users/mojombo/gists{/gist_id}",
            starredUrl: "https://api.github.com/users/mojombo/starred{/owner}{/repo}",
            subscriptionsUrl: "https://api.github.com/users/mojombo/subscriptions",
            organizationsUrl: "https://api.github.com/users/mojombo/orgs",
            reposUrl: "https://api.github.com/users/mojombo/repos",
            eventsUrl: "https://api.github.com/users/mojombo/events{/privacy}",
            receivedEventsUrl: "https://api.github.com/users/mojombo/received_events",
            type: "User",
            siteAdmin: false,
            name: "Tom Preston-Werner",
            company: "@chatterbugapp, @redwoodjs, @preston-werner-ventures ",
            blog: "http://tom.preston-werner.com",
            location: "San Francisco",
            email: "",
            hireable: "",
            bio: "",
            twitterUsername: "mojombo",
            publicRepos: 64,
            publicGists: 62,
            followers: 23326,
            following: 11
        )
    }
}
