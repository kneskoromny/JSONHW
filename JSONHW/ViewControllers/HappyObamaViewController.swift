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
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchImage()

        
    }
    
    private func fetchImage() {
        guard let url = URL(string: URLExamples.happyObama.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            print("!!!!!!!", response)
            guard let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self.imageView.image = image
                self.activityIndicator.stopAnimating()
            }
        }.resume()
    }
    

  

}
