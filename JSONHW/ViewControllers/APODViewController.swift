//
//  ViewController.swift
//  JSONHW
//
//  Created by Кирилл Нескоромный on 30.04.2021.
//

import UIKit

class APODViewController: UIViewController {
    
    //MARK: - Public properties
    
    var apod: NasaPOD?
    
    //MARK: - IB Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    //MARK: - Private methods

}

extension APODViewController {
    func fetchAPOD() {
        var stringURL = ""
        // присвоили переменной String адрес, по которому собираемся переходить
        guard let contentURL = URL(string: URLExamples.nasaAPOD.rawValue) else { return }
        
        // запускаем сессию по нашей ссылке
        URLSession.shared.dataTask(with: contentURL) { data, _, error in
            // проверяем наличие данных
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description!")
                return
            }
            // декодируем файл по нашей структуре
            do {
                // пытаемся сразу присвоить значение переменной внутри контроллера
                self.apod = try JSONDecoder().decode(NasaPOD.self, from: data)
                
                // переключаемся на главный поток
                DispatchQueue.main.async {
                    // обновляем значение лейбла
                    
                    self.descriptionLabel.text = self.apod?.description
                    
                    stringURL = self.apod?.url ?? ""
                    
                    guard let imageURL = URL(string: stringURL) else { return }
                
                    URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
                        guard let data = data else {
                            print(error?.localizedDescription ?? "No error description")
                            return
                        }
                        guard let image = UIImage(data: data) else { return }
                        
                        DispatchQueue.main.async {
                            self.imageView.image = image
                            
                        }
                    }.resume()
                    
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()// обязательный метод в конце сессии
    }
   
}
