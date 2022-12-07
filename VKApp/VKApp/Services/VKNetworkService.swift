// VKNetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation
import RealmSwift

/// Менеджер сетевых запросов по API VK
final class VKNetworkService {
    // MARK: - Constants

    private enum Constants {
        static let methodText = "/method/"
        static let fieldsText = "fields"
        static let accessTokenText = "access_token"
        static let vText = "v"
        static let bdateText = "bdate"
        static let bdateNumberText = "5.131"
        static let baseUrl = "https://api.vk.com"
        static let httpsText = "https"
        static let oauthVkComText = "oauth.vk.com"
        static let authorizeText = "/authorize"
        static let clientIdText = "client_id"
        static let clientIdNumberText = "51485381"
        static let displayText = "display"
        static let mobileText = "mobile"
        static let redirectUriText = "redirect_uri"
        static let redirectUriValueText = "https://oauth.vk.com/blank.html"
        static let scopeText = "scope"
        static let scopeNumberText = "8198"
        static let responseTypeText = "response_type"
        static let tokenText = "token"
        static let vValueText = "5.68"
        static let groupsGetText = "groups.get"
        static let userIdText = "user_id"
        static let userIdNumberText = "43832436"
        static let extendedText = "extended"
        static let numberOneText = "1"
        static let groupsSearchText = "groups.search"
        static let qText = "q"
        static let photosGetAllText = "photos.getAll"
        static let ownerIdText = "owner_id"
        static let friendsGetText = "friends.get"
        static let photoText = "photo_100"
        static let newsfeedGetText = "newsfeed.get"
        static let countText = "count"
        static let countNumberText = "40"
        static let usersGetText = "users.get"
    }

    // MARK: - Private Properties

    private var generalParameters: Parameters = [
        Constants.fieldsText: Constants.bdateText,
        Constants.accessTokenText: Session.shared.token,
        Constants.vText: Constants.bdateNumberText
    ]

    private lazy var parametersGroupVK: Parameters = {
        var parameters = generalParameters
        parameters[Constants.userIdText] = "\(Session.shared.userId)"
        parameters[Constants.extendedText] = Constants.numberOneText
        return parameters
    }()

    private lazy var parametersFriendsVK: Parameters = {
        var parameters = generalParameters
        parameters[Constants.userIdText] = "\(Session.shared.userId)"
        parameters[Constants.fieldsText] = Constants.photoText
        return parameters
    }()

    private lazy var parametersUsersGetVK: Parameters = {
        var parameters = generalParameters
        parameters[Constants.fieldsText] = Constants.photoText
        return parameters
    }()

    // MARK: - Public Methods

    func fetchFriendsVK(completion: @escaping ([ItemPerson]) -> ()) {
        let path = "\(Constants.methodText)\(Constants.friendsGetText)"
        let url = "\(Constants.baseUrl)\(path)"
        AF.request(url, method: .get, parameters: parametersFriendsVK).responseData { response in
            guard
                let data = response.value else { return }
            guard let items = try? JSONDecoder().decode(Person.self, from: data).response.items
            else { return }
            completion(items)
        }
    }

    func fetchPhotosVK(person: ItemPerson, completion: @escaping (ItemPerson) -> ()) {
        let path = "\(Constants.methodText)\(Constants.photosGetAllText)"
        let url = "\(Constants.baseUrl)\(path)"
        var parametersPhotos = generalParameters
        parametersPhotos[Constants.ownerIdText] = "\(person.id)"
        AF.request(url, method: .get, parameters: parametersPhotos).responseData { response in
            guard
                let data = response.value,
                let items = try? JSONDecoder().decode(Photo.self, from: data).response.items
            else { return }
            let updatePerson = person
            let photosPerson = List<ItemPhoto>()
            photosPerson.append(objectsIn: items)
            updatePerson.photos = photosPerson
            completion(updatePerson)
        }
    }

    func fetchUserGroupsVK(completion: @escaping (Result<[VKGroups], Error>) -> Void) {
        let path = "\(Constants.methodText)\(Constants.groupsGetText)"
        let url = "\(Constants.baseUrl)\(path)"
        AF.request(url, method: .get, parameters: parametersGroupVK).responseData { response in
            guard let data = response.value else { return }
            do {
                let items = try JSONDecoder().decode(VKGroup.self, from: data).response.items
                completion(.success(items))
            } catch {
                completion(.failure(error))
            }
        }
    }

    func fetchSearchGroupsVK(searchText: String, completion: @escaping ([VKGroups]) -> Void) {
        let path = "\(Constants.methodText)\(Constants.groupsSearchText)"
        let url = "\(Constants.baseUrl)\(path)"
        var parametersSearchGroupVK = generalParameters
        parametersSearchGroupVK[Constants.qText] = searchText
        AF.request(url, method: .get, parameters: parametersSearchGroupVK).responseData { response in
            guard
                let data = response.value,
                let items = try? JSONDecoder().decode(VKGroup.self, from: data).response.items
            else { return }
            completion(items)
        }
    }

    func fetchUserNewsVK(completion: @escaping (Result<[Newsfeed], Error>) -> Void) {
        let path = "\(Constants.methodText)\(Constants.newsfeedGetText)"
        let url = "\(Constants.baseUrl)\(path)"
        var parametersSearchGroupVK = generalParameters
        parametersSearchGroupVK[Constants.countText] = Constants.countNumberText
        AF.request(url, method: .get, parameters: parametersSearchGroupVK).responseData { response in
            guard let data = response.value else { return }
            do {
                let items = try JSONDecoder().decode(VKNews.self, from: data).response.items
                completion(.success(items))
            } catch {
                completion(.failure(error))
            }
        }
    }

    func fetchAuthorVK(authorID: String, completion: @escaping (ResponseUsersGet) -> Void) {
        let path = "\(Constants.methodText)\(Constants.usersGetText)"
        let url = "\(Constants.baseUrl)\(path)"
        var parametersUsersGetVK = parametersUsersGetVK
        parametersUsersGetVK[Constants.userIdText] = authorID
        AF.request(url, method: .get, parameters: parametersUsersGetVK).responseData { response in
            guard
                let data = response.value,
                let items = try? JSONDecoder().decode(UsersGet.self, from: data).response,
                let author = items.first
            else { return }
            completion(author)
        }
    }

    func createUrlComponents() -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.httpsText
        urlComponents.host = Constants.oauthVkComText
        urlComponents.path = Constants.authorizeText
        urlComponents.queryItems = [
            URLQueryItem(name: Constants.clientIdText, value: Constants.clientIdNumberText),
            URLQueryItem(name: Constants.displayText, value: Constants.mobileText),
            URLQueryItem(name: Constants.redirectUriText, value: Constants.redirectUriValueText),
            URLQueryItem(name: Constants.scopeText, value: Constants.scopeNumberText),
            URLQueryItem(name: Constants.responseTypeText, value: Constants.tokenText),
            URLQueryItem(name: Constants.vText, value: Constants.vValueText)
        ]
        return urlComponents
    }

    func loadData(urlPath: String?, completion: @escaping (Data?) -> ()) {
        guard
            let urlPath = urlPath,
            let url = URL(string: urlPath)
        else { return }
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            completion(data)
        }
    }
}
