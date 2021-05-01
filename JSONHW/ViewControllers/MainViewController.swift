//
//  ViewController.swift
//  JSONHW
//
//  Created by Кирилл Нескоромный on 30.04.2021.
//

import UIKit

enum URLExamples: String {
    case nasaAPOD = "https://api.nasa.gov/planetary/apod?api_key=lKtTVBLWcJwffu52fyYVGG2E8tjyEsp04LWMtLtx"
    case happyObama = "http://apimeme.com/meme?meme=2nd-Term-Obama&top=&bottom=когда+распарсил+свой+первый+json"
    
}

class MainViewController: UIViewController {

    
    //MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let apodVC = segue.destination as! NasaPODViewController
        apodVC.fetchAPOD()
        
    }

    //MARK: - IB Actions
    @IBAction func buttonOnePressed(_ sender: UIButton) {
//        buttonOnePressed()
    }
    @IBAction func buttonTwoPressed(_ sender: UIButton) {
        buttonPressed()
    }
    @IBAction func buttonThreePressed(_ sender: UIButton) {
    }
    @IBAction func buttonFourPressed(_ sender: UIButton) {
    }
    
    //MARK: - Private Methods
    
    private func successAlert() {
        // переключаемся на главный поток
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Success",
                message: "You can see the results in the Debug area",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
    
    private func failedAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Failed",
                message: "You can see error in the Debug area",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
   
    // метод для предварительного вывода в консоль
    private func buttonPressed() {
        // присвоили переменной String адрес, по которому собираемся переходить
        guard let url = URL(string: URLExamples.happyObama.rawValue) else { return }
        
        // запускаем сессию по нашей ссылке
        URLSession.shared.dataTask(with: url) { data, _, error in
            // проверяем наличие данных
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description!")
                return
            }
            if let image = UIImage(data: data) {
                print(image)
                self.successAlert()
            } else {
                self.failedAlert()
            }
            
        }.resume() // обязательный метод в конце сессии
    }
    
    
}

