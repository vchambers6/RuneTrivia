//
//  EntrepRUNEurQuestionCardView.swift
//  RuneTrivia
//
//  Created by Vanessa Chambers on 5/18/24.
//

import UIKit

class EntrepRUNEurQuestionCardView: UIView {
    
    let indexLabel = UILabel()
    let questionLabel = UILabel()
    let imageView = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        indexLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        questionLabel.numberOfLines = 4
        
        addSubview(indexLabel)
        addSubview(imageView)
        addSubview(questionLabel)
        
        
        NSLayoutConstraint.activate([
            // Center x
            indexLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            questionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            // vertical stack
            indexLabel.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.topAnchor.constraint(equalTo: indexLabel.bottomAnchor, constant: 10),
            questionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            
            // width and height
            indexLabel.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor),
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0),
            imageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0),
            questionLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0)
        ])
    }
    
    func populateView(with data: EntrepRUNEurQuestion, at index: Int, showAnswer: Bool = false) {
        indexLabel.text = "Round \(index + 1)"
        imageView.image = data.image
        
        

        
        if showAnswer {
            let itemName = NSMutableAttributedString(string: data.name, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)])
            let answerSuffix = NSAttributedString(string: " costs \(data.price) GP at the GE", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)])
            itemName.append(answerSuffix)
            questionLabel.attributedText = itemName
        } else {
            let question = NSMutableAttributedString(string: "How much does ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)])
            let itemName = NSAttributedString(string: data.name, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)])
            let questionSuffix = NSAttributedString(string: " curerntly cost at the GE?", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)])
            
            question.append(itemName)
            question.append(questionSuffix)
            
            questionLabel.attributedText = question
           
        }
        
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
