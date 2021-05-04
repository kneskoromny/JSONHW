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
        guard let apodVC = segue.destination as? NasaPODViewController else { return }
//        apodVC.fetchData()
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

