// GetDataOperation.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

/// Операция по получению данных  из сети
final class GetDataOperation: AsyncOperation {
    // MARK: - Constants

    private enum Constants {
        static let methodText = "/method/"
        static let fieldsText = "fields"
        static let accessTokenText = "access_token"
        static let vText = "v"
        static let bdateNumberText = "5.131"
        static let baseUrl = "https://api.vk.com"
        static let userIdText = "user_id"
        static let friendsGetText = "friends.get"
        static let photoText = "photo_100"
    }

    // MARK: - Public Properties

    var data: Data?

    // MARK: - Private Properties

    private lazy var parametersFriendsVK: Parameters = [
        Constants.accessTokenText: Session.shared.token,
        Constants.vText: Constants.bdateNumberText,
        Constants.userIdText: "\(Session.shared.userId)",
        Constants.fieldsText: Constants.photoText
    ]

    // MARK: - Public Methods

    override func main() {
        let path = "\(Constants.methodText)\(Constants.friendsGetText)"
        let url = "\(Constants.baseUrl)\(path)"
        AF.request(url, method: .get, parameters: parametersFriendsVK).responseData { [weak self] response in
            guard
                let self = self,
                let data = response.value
            else { return }
            self.data = data
            self.state = .finished
        }
    }
}
