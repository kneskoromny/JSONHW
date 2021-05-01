//
//  ViewController.swift
//  JSONHW
//
//  Created by Кирилл Нескоромный on 30.04.2021.
//

import Spring


enum URLExamples: String {
    case nasaAPOD = "https://api.nasa.gov/planetary/apod?api_key=lKtTVBLWcJwffu52fyYVGG2E8tjyEsp04LWMtLtx"
    case happyObama = "https://i.postimg.cc/9XD970g1/image.jpg"
    
}

class MainViewController: UIViewController {

    @IBOutlet weak var springLabel: SpringLabel!
    
    @IBOutlet weak var topButton: SpringButton!
    @IBOutlet weak var midButton: SpringButton!
    @IBOutlet weak var botButton: SpringButton!
    
    
    //MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        springLabel.animation = "slideDown"
        springLabel.animate()
        
        buttonAnimate(object: topButton, animation: "slideRight", delay: 1.0, force: 1.5)
        buttonAnimate(object: midButton, animation: "slideLeft", delay: 1.5, force: 1.5)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let apodVC = segue.destination as? NasaPODViewController else { return }
        apodVC.fetchAPOD()
        
    }

    //MARK: - IB Actions
    @IBAction func buttonOnePressed(_ sender: UIButton) {
//        buttonOnePressed()
    }
    @IBAction func buttonTwoPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "showObama", sender: nil)
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
    
    private func buttonAnimate(object: SpringButton, animation: String, delay: CGFloat, force: CGFloat) {
        object.animation = animation
        object.delay = delay
        object.force = force
        object.animate()
    }
    
    
}

