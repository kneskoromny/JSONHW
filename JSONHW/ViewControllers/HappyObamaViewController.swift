//
//  HappyObamaViewController.swift
//  JSONHW
//
//  Created by Кирилл Нескоромный on 01.05.2021.
//

import UIKit

class HappyObamaViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.layer.cornerRadius = imageView.frame.height / 10
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchImage()

        
    }
    
    private func fetchImage() {
        guard let url = URL(string: URLExamples.happyObama.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            guard let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self.imageView.image = image
                self.activityIndicator.stopAnimating()
            }
        }.resume()
    }
}
