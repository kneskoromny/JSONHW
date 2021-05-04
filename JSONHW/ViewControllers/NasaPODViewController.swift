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
        fetchData(from: APIManager.shared.nasaAPOD)
    }
    
    private func fetchData(from url: String?) {
        NetworkManager.shared.fetchAPOD(from: url) { apod in
            self.apod = apod
            self.descriptionLabel.text = apod.description
            
            guard let imageURL = URL(string: apod.url ?? "") else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            self.imageView.image = UIImage(data: imageData)
          
        }
    }
    
}
