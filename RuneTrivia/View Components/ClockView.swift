//
//  ClockView.swift
//  RuneTrivia
//
//  Created by Vanessa Chambers on 5/17/24.
//

import UIKit

class ClockView: UIView {
    var countdownLabel: UILabel!
    var clockImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        clockImageView = UIImageView()
        clockImageView.image = UIImage(systemName: "alarm")
        clockImageView.tintColor = .green
        clockImageView.translatesAutoresizingMaskIntoConstraints = false
        clockImageView.contentMode = .scaleAspectFit
        self.addSubview(clockImageView)
        
        countdownLabel = UILabel()
        countdownLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        countdownLabel.textAlignment = .center
        countdownLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(countdownLabel)
        self.bringSubviewToFront(countdownLabel)
        
        NSLayoutConstraint.activate([
            clockImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            clockImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            countdownLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            countdownLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            clockImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0),
            clockImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0)
            
        ])
    }
    
    func updateTimer(to time: Int) {
        switch time {
        case 1...10:
            clockImageView.tintColor = .yellow
        case 0:
            clockImageView.tintColor = .red
        default:
            clockImageView.tintColor = .green
        }
        
        let timeString = String(time)
        countdownLabel.text = timeString
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
