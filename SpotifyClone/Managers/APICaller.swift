//
//  APICaller.swift
//  SpotifyClone
//
//  Created by Doğan Ensar Papuçcuoğlu on 16.10.2024.
//

import Foundation


final class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    struct Constants {
        static let baseURL: String = "https://api.spotify.com/v1"
    }
    
    enum APIError: Error {
        case failedToGetData
    }
        
    public func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        createRequest(
            with: URL(string: Constants.baseURL + "/me"),
            type: .GET
        ) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
                    completion(.success(result))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    //MARK: - Private
    
    enum HTTPMethod: String {
        case GET = "GET"
        case POST = "POST"
    }
    
    private func createRequest(
        with url: URL?,
        type: HTTPMethod,
        completion: @escaping (URLRequest) -> Void
    ) {
        AuthManager.shared.withValidToken { token in
            guard let apiUrl = url else {
                return
            }
            var request = URLRequest(url: apiUrl)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
    }
}
