//
//  EntrepRUNEurGameViewController.swift
//  RuneTrivia
//
//  Created by Vanessa Chambers on 5/17/24.
//

import UIKit

class EntrepRUNEurGameViewController: UIViewController {

    var secondsRemaining: Int = 20
    var timer: Timer?
    var latestPriceData: LatestPriceData?
    var pricesMappingData: PriceMappingData?
    var questions: [EntrepRUNEurQuestion] = []
    var currentIndex: Int?
    
    // Views:
    var clock: ClockView!
//    var currentImage: UIImageView!
    var questionView: EntrepRUNEurQuestionCardView!
    var showAnswerButton: UIButton!
    var showingAnswerText = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Back Button -- top left corner
        
        self.view.backgroundColor = .white
        let backButton = UIBarButtonItem(image: UIImage(systemName: "x.circle.fill"), style: .plain, target: self, action: #selector(closeButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        self.title = "EntrepRUNEur"
        
        // Timer - should go in top right corner
        clock = ClockView()
        clock.setupView()
        clock.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(clock)
        
        
//        currentImage = UIImageView()
//        currentImage.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(currentImage)
        
        showAnswerButton = UIButton(type: .system)
        showAnswerButton.setTitle("Show Answer", for: .normal)
        showAnswerButton.backgroundColor = .systemPink
        showAnswerButton.translatesAutoresizingMaskIntoConstraints = false
        showAnswerButton.addTarget(self, action: #selector(showAnswerButtonTapped), for: .touchUpInside)
        
        self.view.addSubview(showAnswerButton)
        
        questionView = EntrepRUNEurQuestionCardView()
        questionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(questionView)
        
        NSLayoutConstraint.activate([
            clock.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            clock.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            clock.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.15),
            clock.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.15),
            
//            currentImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
//            currentImage.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
//            currentImage.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
//            currentImage.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5)
            
            questionView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            questionView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            questionView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
            questionView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.8),
            
            showAnswerButton.topAnchor.constraint(equalTo: questionView.bottomAnchor, constant: 20),
            showAnswerButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
            
        ])
        
        
        
        // Get the questions
        Task {
            await fetchLatestPrices()
            await fetchPricesMapping()
            await getTenQuestions()
            
            print(self.questions)
            startGame()
        }
    
    }
}

// Data downloading and processing methods
extension EntrepRUNEurGameViewController {
    
    func getTenQuestions() async{
        var ids = Set<Int>()
        
        // Get set of random IDs
        guard let mapping = self.pricesMappingData, mapping.count >= 10  else {
            fatalError("Not enough data downloaded to play EntrepRUNEur")
        }
        guard let latestPrices = self.latestPriceData, latestPrices.count >= 10  else {
            fatalError("Not enough data downloaded to play EntrepRUNEur")
        }
        while ids.count < 10 {
            let rand = Int.random(in: 0..<mapping.count)
            
            if mapping.keys.contains(rand), latestPrices.keys.contains(String(rand)) {
                ids.insert(rand)
            }
            
        }
        
        for id in ids {
            guard let latestPrice = latestPrices[String(id)] else {
                fatalError("Invalid ID when trying to link latest price to mapping")
            }
            guard let priceMapping = mapping[id] else {
                fatalError("Invalid ID when trying to link latest price to mapping")
            }
            await downloadImage(at: priceMapping.icon) { res in
                switch res {
                case .success(let img):
                    let question = EntrepRUNEurQuestion(image: img, name: priceMapping.name, price: latestPrice.high!)
                    self.questions.append(question)
                    
                case .failure(let error):
                    print("Error fetching latest prices: \(error.localizedDescription)")
                }
            }
        }
    }
//    func downloadImage(at fileName: String, completion: @escaping(<UIImage, Error>) -> Void) async -> {
//        let client = OSRSPricesClient()
//        await client.fetchImage(at: fileName) { res in
//            switch res {
//            case .success(let img):
////                DispatchQueue.main.async {
////                    self.currentImage.image = img
////                }
////                print("it worked?")
//                return img
//            case .failure(let error):
//                print("Error fetching latest prices: \(error.localizedDescription)")
//                return nil
//            }
//        }
//        
//    }
    
    func downloadImage(at fileName: String, completion: @escaping(Result<UIImage, Error>) -> Void) async {
        let client = OSRSPricesClient()
        await client.fetchImage(at: fileName, completion: completion)
        
    }
    
    func fetchLatestPrices() async {
        let client = OSRSPricesClient()
        await client.fetchLatestPrices { res in
            switch res {
            case .success(let latestPrices):
                //                print("okayyy \(latestPrices)")
                self.latestPriceData = latestPrices
                return
            case .failure(let error):
                print("Error fetching latest prices: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchPricesMapping() async {
        let client = OSRSPricesClient()
        await client.fetchPricesMapping { res in
            switch res {
            case .success(let pricesMappingData):
//                                print("here's mapping \(pricesMappingData)")
                self.pricesMappingData = pricesMappingData
                return
            case .failure(let error):
                print("Error fetching prices mapping: \(error)")
            }
        }
    }
}

// Timer + other util methods
extension EntrepRUNEurGameViewController {
    
    
    @objc func showAnswerButtonTapped() {
        if showingAnswerText {
            showingAnswerText = false
            showAnswerButton.setTitle("Next", for: .normal)
            secondsRemaining = 0
            updateTimer()
            
        } else {
            showingAnswerText = true
            currentIndex = (currentIndex! + 1) % questions.count
            updateQuestionCard(showAnswer: false)
            showAnswerButton.setTitle("Show Answer", for: .normal)
            secondsRemaining = 15
            startTimer()
            
        }
        
    }
    
    func updateQuestionCard(showAnswer: Bool = false) {
        UIView.transition(with: questionView, duration: 0.3, options: .transitionCrossDissolve, animations: {
            guard let currentIndex = self.currentIndex else { return }
            self.questionView.populateView(with: self.questions[currentIndex], at: currentIndex, showAnswer: showAnswer)
        }, completion: nil)
    }
    
    
    func startGame() {

        self.currentIndex = 0
        self.questionView.populateView(with: self.questions[0], at: 0)
        // Start timer
        startTimer()
    }
    
    func startTimer() {
        // start the timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    @objc func updateTimer() {
        if secondsRemaining > 0 {
//            print("clock is at \(secondsRemaining)")
            clock.updateTimer(to: secondsRemaining)
            secondsRemaining-=1
            
        } else {
            clock.updateTimer(to: secondsRemaining)
            stopTimer()
            updateQuestionCard(showAnswer: true)
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        showAnswerButton.setTitle("Next", for: .normal)
        showingAnswerText = false
        
    }
    
    
    
    
    @objc func closeButtonTapped() {
        let homeVC = HomeViewController()
        navigationController?.pushViewController(homeVC, animated: true)
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
