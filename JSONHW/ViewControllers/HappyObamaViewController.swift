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
}

extension HappyObamaViewController {
    // версия работы с json при загрузке только изображения
    func fetchImage() {
        // получаем ссылку по string
        guard let url = URL(string: URLExamples.happyObama.rawValue) else { return }
        
        // запускаем сессию
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            // проверяем данные
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            // создаем переменную из полученных данных
            guard let image = UIImage(data: data) else { return }
            
            // главный поток и загрузка изображения на вью
            DispatchQueue.main.async {
                self.imageView.image = image
                self.activityIndicator.stopAnimating()
            }
        }.resume()
    }
}
