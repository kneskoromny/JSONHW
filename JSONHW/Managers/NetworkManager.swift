//
//  NetworkManager.swift
//  JSONHW
//
//  Created by Кирилл Нескоромный on 04.05.2021.
//

import Foundation

class NetworkManager {
    // все менеджеры должны быть синглтонами
    static let shared = NetworkManager()
    private init() {}
    
    func fetchAPOD(from url: String?, with completion: @escaping (NasaPOD) -> Void) {
        guard let stringURL = url else { return }
        guard let contentURL = URL(string: stringURL) else { return }
       
        URLSession.shared.dataTask(with: contentURL) { data, _, error in
            
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description!")
                return
            }
            do {
                let apod = try JSONDecoder().decode(NasaPOD.self, from: data)
            
                DispatchQueue.main.async {
                    completion(apod)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    func fetchJoke(from url: String?, with completion: @escaping ([Joke]) -> Void) {
        guard let stringURL = url else { return }
        guard let contentURL = URL(string: stringURL) else { return }
        
        URLSession.shared.dataTask(with: contentURL) { data, response, error in
            guard let data = data else {
                print("error 1")
                print(error?.localizedDescription ?? "No error description!")
                return
            }
            do {
                let jokes = try JSONDecoder().decode([Joke].self, from: data)
                print("super 2")
                completion(jokes)
            } catch let error {
                print(error)
            }
            
        }.resume()
    }
    
}
