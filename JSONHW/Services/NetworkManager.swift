//
//  NetworkManager.swift
//  JSONHW
//
//  Created by Кирилл Нескоромный on 01.05.2021.
//

import UIKit

struct NetworkManager {
    
    public func fetchData(with url: String, and completionHandler: (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            guard let image = UIImage(data: data) else { return }
            
        }.resume()
        
    }
}
