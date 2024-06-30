//
//  SplashScreenViewController.swift
//  PicsumPhotos
//
//  Created by Ruchira  on 30/06/24.
//

import UIKit

class SplashScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set a white background and add your image in the center
        view.backgroundColor = .white
        
        let imageView = UIImageView(image: UIImage(named: "PicsumPhotos.png"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200), // Adjust as needed
            imageView.heightAnchor.constraint(equalToConstant: 200) // Adjust as needed
        ])
        
        // Navigate to HomeViewController after 5 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.navigateToHomeViewController()
        }
    }
    
    private func navigateToHomeViewController() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let homeViewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
            homeViewController.modalTransitionStyle = .crossDissolve
            homeViewController.modalPresentationStyle = .fullScreen
            self.present(homeViewController, animated: true, completion: nil)
        }
    }
}

