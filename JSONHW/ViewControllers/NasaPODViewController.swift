//
//  ViewController.swift
//  JSONHW
//
//  Created by Кирилл Нескоромный on 30.04.2021.
//

import UIKit

class NasaPODViewController: UIViewController {
    
    //MARK: - Public properties
    // локальная переменная, в которую будем декодить json
    var apod: NasaPOD?
    
    //MARK: - IB Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // запускаем activityIndicator
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        descriptionLabel.text = """
            Please, wait few seconds.
            Now we're uploading something interesting for you:)
            """
    }
}

extension NasaPODViewController {
    func fetchAPOD() {
        
        // присвоили переменной String адрес, по которому собираемся переходить
        guard let contentURL = URL(string: URLExamples.nasaAPOD.rawValue) else { return }
        
        // запускаем сессию по нашей ссылке
        URLSession.shared.dataTask(with: contentURL) { data, _, error in
            // проверяем наличие данных
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description!")
                return
            }
            // декодируем файл по нашей структуре через do/catch - позволяет поймать ошибку
            do {
                // пытаемся сразу присвоить значение переменной внутри контроллера, декодируя json
                self.apod = try JSONDecoder().decode(NasaPOD.self, from: data)
                // работа с картинкой - создаем переменную с URL адресом по string из json
                guard let imageURL = URL(string: self.apod?.url ?? "") else { return }
                // создаем переменную типа Data по инициализатору URL
                guard let imageData = try? Data(contentsOf: imageURL) else { return }
                // переключаемся на главный поток
                DispatchQueue.main.async {
                    // обновляем значение лейбла
                    self.descriptionLabel.text = self.apod?.description
                    // обновляем значение картинки по инициализатору Data
                    self.imageView.image = UIImage(data: imageData)
                    // останавливаем activityIndicator
                    self.activityIndicator.stopAnimating()
                    
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()// обязательный метод в конце сессии
    }
   
}
