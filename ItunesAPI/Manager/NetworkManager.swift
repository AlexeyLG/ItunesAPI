//
//  NetworkManager.swift
//  ItunesAPI
//
//  Created by Alexey on 29.03.21.
//

import Foundation

class NetworkManager {
    
    private var dataTask: URLSessionDataTask?
    
    func loadArtistInfo(name: String?, completion: @escaping ((SearchResults) -> Void)) -> Void {
        
        guard let name = name else { return }
        
        let session = URLSession(configuration: .default)
        guard let url = URL(string: "https://itunes.apple.com/search?term=\(name)") else { return }
        
        dataTask?.cancel()
        dataTask = session.dataTask(with: url) { (data, _, error) in
            
            guard error == nil, let data = data else {
                print(error ?? "Data is nil")
                return
            }
            do {
                let searchResults = try JSONDecoder().decode(SearchResults.self, from: data)
                DispatchQueue.main.async {
                    completion(searchResults)
                }
            } catch {
                print(error)
            }
        }
        dataTask?.resume()
    }
    
}
