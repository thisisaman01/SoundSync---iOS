//
//  APIManager.swift
//  SoundSync
//
//  Created by AMAN K.A on 25/11/23.
//

import Foundation

class APIManager {
    static let baseURL = "https://cms.samespace.com/items/"

    static func fetchTopTracks(completion: @escaping (Result<Music, Error>) -> Void) {
        fetchData(endpoint: "songs", completion: completion)
    }

    static func fetchSongs(completion: @escaping (Result<Music, Error>) -> Void) {
        fetchData(endpoint: "songs", completion: completion)
    }

    private static func fetchData<T: Decodable>(endpoint: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: baseURL + endpoint) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }

            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

