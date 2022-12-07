// NetworkOperation.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

///
final class NetworkOperation: AsyncOperation {
    // MARK: - Constants

    private enum Constants {
        static let methodText = "/method/"
        static let fieldsText = "fields"
        static let accessTokenText = "access_token"
        static let vText = "v"
        static let bdateText = "bdate"
        static let bdateNumberText = "5.131"
        static let baseUrl = "https://api.vk.com"
        static let userIdText = "user_id"
        static let friendsGetText = "friends.get"
        static let photoText = "photo_100"
    }

    // MARK: - Public Properties

    var result: Result<[ItemPerson], Error>?

    // MARK: - Private Properties

    private var generalParameters: Parameters = [
        Constants.fieldsText: Constants.bdateText,
        Constants.accessTokenText: Session.shared.token,
        Constants.vText: Constants.bdateNumberText
    ]

    private lazy var parametersFriendsVK: Parameters = {
        var parameters = generalParameters
        parameters[Constants.userIdText] = "\(Session.shared.userId)"
        parameters[Constants.fieldsText] = Constants.photoText
        return parameters
    }()

    override func main() {
        let path = "\(Constants.methodText)\(Constants.friendsGetText)"
        let url = "\(Constants.baseUrl)\(path)"
        AF.request(url, method: .get, parameters: parametersFriendsVK).responseData { response in
            guard let data = response.value else { return }
            do {
                let items = try JSONDecoder().decode(Person.self, from: data).response.items
                self.result = .success(items)
                // self.completion(.success(items))
            } catch {
                // self.completion(.failure(error))
                self.result = .failure(error)
            }
            self.state = .finished
        }
    }
}
