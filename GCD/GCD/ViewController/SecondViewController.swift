//
//  SecondViewController.swift
//  GCD
//
//  Created by Жадаев Алексей on 19.05.2021.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    fileprivate var imageURL: URL?
    fileprivate var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            imageView.image = newValue
            imageView.sizeToFit()
//            imageView.contentMode = .scaleAspectFill
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
        delay(3) {
            self.loginAlert()
        }
    }
    
    fileprivate func delay(_ delay: Int, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            closure()
        }
    }
    
    fileprivate func loginAlert() {
        let alertController = UIAlertController(title: "Вы зарегистрированы?", message: "Введите логин и пароль", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        let noAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        alertController.addTextField { (userName) in
            userName.placeholder = "Логин"
        }
        alertController.addTextField { (userPassword) in
            userPassword.placeholder = "Пароль"
            userPassword.isSecureTextEntry = true
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    fileprivate func fetchImage() {
        imageURL = URL(string: "https://images.wallpaperscraft.ru/image/ozero_gory_derevia_129959_3840x2160.jpg")
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            guard let url = self.imageURL, let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
