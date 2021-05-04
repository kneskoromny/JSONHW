//
//  ViewController.swift
//  JSONHW
//
//  Created by Кирилл Нескоромный on 30.04.2021.
//

import UIKit

class NasaPODViewController: UIViewController {
    
    //MARK: - Public properties
    var apod: NasaPOD?
    
    //MARK: - IB Outlets
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
       
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        descriptionLabel.text = """
            Пожалуйста, подождите пару секунд.
            Я загружаю кое-что интересное для Вас:)
            """
    }
}

extension NasaPODViewController {
    func fetchAPOD() {
        guard let contentURL = URL(string: URLExamples.nasaAPOD.rawValue) else { return }
       
        URLSession.shared.dataTask(with: contentURL) { data, _, error in
            
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description!")
                return
            }
            do {
                self.apod = try JSONDecoder().decode(NasaPOD.self, from: data)
                guard let imageURL = URL(string: self.apod?.url ?? "") else { return }
                guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
                DispatchQueue.main.async {
                    self.descriptionLabel.text = self.apod?.description
                    self.imageView.image = UIImage(data: imageData)
                    self.activityIndicator.stopAnimating()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
