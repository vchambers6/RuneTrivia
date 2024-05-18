//
//  InformationViewController.swift
//  RuneTrivia
//
//  Created by Vanessa Chambers on 5/17/24.
//

import UIKit

class InformationViewController: UIViewController {
    
    var game: Game?
    var infoText: UITextView!
    var playButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = game?.title
        self.view.backgroundColor = .blue
        
        // Info text
        infoText = UITextView()
        infoText.text = game?.information
        infoText.isEditable = false
        infoText.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(infoText)
        
        // Play button
        playButton = UIButton(type: .system)
        playButton.setTitle("Let's play!", for: .normal)
        playButton.backgroundColor = .green
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        self.view.addSubview(playButton)
        
        NSLayoutConstraint.activate([
            infoText.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            infoText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            infoText.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
            infoText.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5),
            
            // Button constraints
            
            playButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            playButton.topAnchor.constraint(equalTo: infoText.bottomAnchor, constant: 10),
            playButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
            playButton.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1)
        ])
    }
    
    @objc func buttonTapped() {
        let entrepRUNEurVC = EntrepRUNEurGameViewController()
        navigationController?.pushViewController(entrepRUNEurVC, animated: true)
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
