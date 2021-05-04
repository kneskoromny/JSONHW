//
//  ViewController.swift
//  JSONHW
//
//  Created by Кирилл Нескоромный on 30.04.2021.
//

import Spring

//enum URLExamples: String {
//    case nasaAPOD = "https://api.nasa.gov/planetary/apod?api_key=lKtTVBLWcJwffu52fyYVGG2E8tjyEsp04LWMtLtx"
//    case happyObama = "https://i.postimg.cc/9XD970g1/image.jpg"
//}

class MainViewController: UIViewController {

    @IBOutlet weak var springLabel: SpringLabel!
    
    @IBOutlet weak var topButton: SpringButton!
    @IBOutlet weak var midButton: SpringButton!
    
    //MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        springLabel.animation = "slideDown"
        springLabel.animate()
        
        buttonAnimate(
            object: topButton,
            animation: "slideUp",
            duration: 3.0,
            delay: 1.0,
            force: 1.5
        )
        buttonAnimate(
            object: midButton,
            animation: "slideUp",
            duration: 3.0,
            delay: 2.0,
            force: 1.0
        )
        
        UIView.animateKeyframes(withDuration: 4.0, delay: 2.0) {
            self.springLabel.textColor = .black
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
                self.topButton.backgroundColor = UIColor(
                    red: 87/255,
                    green: 107/255,
                    blue: 224/255,
                    alpha: 1.0
                )
            }
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0) {
                self.midButton.backgroundColor = UIColor(
                    red: 218/255,
                    green: 128/255,
                    blue: 147/255,
                    alpha: 1.0
                )
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationVC = segue.destination as! UINavigationController
        let jokesVC = navigationVC.topViewController as! JokesViewController

    }
    
    
    @IBAction func testButtonPressed() {
        fetchJoke()
    }
    
    
    //MARK: - Private Methods
    private func buttonAnimate(
        object: SpringButton,
        animation: String,
        duration: CGFloat,
        delay: CGFloat,
        force: CGFloat
    ) {
        object.animation = animation
        object.duration = duration
        object.delay = delay
        object.force = force
        object.animate()
    }
    
    
}

extension MainViewController {
    func fetchJoke() {
        guard let contentURL = URL(string: APIManager.shared.joke) else { return }
        
        URLSession.shared.dataTask(with: contentURL) { data, response, error in
            if let error = error {
                print("error 1")
                print(error.localizedDescription)
            }
            guard let data = data, let response = response else { return }
            print("well! 2")
            print(response)
            do {
                let jokes = try JSONDecoder().decode([Joke].self, from: data)
                print("super! 3")
                print(jokes)
            } catch {
                print("error 4")
                print(error.localizedDescription)
            }
        }.resume()
        
        
        
    }
}

