//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    let questionsPerRound = 4
    var questionsAsked = 0
    var correctQuestions = 0
    var currentQuestionAnswer:[String : Any] = ["Question": "This was the only US President to serve more than two consecutive terms.",
                                                "Options": ["George Washington","Franklin D. Roosevelt","Woodrow Wilson","Andrew Jackson"],
                                                "Answer":2]

    var gameSound: SystemSoundID = 0
    var gameCorrectSound: SystemSoundID = 0
    var gameFailSound: SystemSoundID = 0
    var gameCompletedSound: SystemSoundID = 0

    let questionProvider = QuestionProvider()

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var option3Button: UIButton!
    @IBOutlet weak var option4Button: UIButton!


    @IBOutlet weak var nextQuestionButton: UIButton!
    
    var buttonArray:[UIButton] = []
    
    
    @IBOutlet weak var playAgainButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonArray = [option1Button,option2Button,option3Button,option4Button]
        for optionButton in buttonArray{
            optionButton.layer.cornerRadius = 10;
            optionButton.clipsToBounds = true
        }
        nextQuestionButton.layer.cornerRadius = 10;
        nextQuestionButton.clipsToBounds = true
        
        playAgainButton.layer.cornerRadius = 10;
        playAgainButton.clipsToBounds = true

        
        loadGameStartSound()
        // Start game
        playGameStartSound()
        displayQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayQuestion() {
        currentQuestionAnswer = questionProvider.randomQuestion()
        questionField.text = currentQuestionAnswer["Question"] as! String?
        let options:[String] = currentQuestionAnswer["Options"] as! [String]
        option1Button.setTitle(options[0], for: .normal)
        option2Button.setTitle(options[1], for: .normal)
        option3Button.setTitle(options[2], for: .normal)
        option4Button.setTitle(options[3], for: .normal)
        
        
        for optionButton in buttonArray{
            optionButton.isEnabled = true
        }
        

        playAgainButton.isHidden = true
    }
    
    func displayScore() {
        playGameCompletedSound()
        // Hide the answer buttons
        option1Button.isHidden = true
        option2Button.isHidden = true
        option3Button.isHidden = true
        option4Button.isHidden = true
        // Display play again button
        playAgainButton.isHidden = false
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        
        print("Selected tag >>> \(sender.tag)");
        
        for optionButton in buttonArray{
            if(optionButton != sender){
                optionButton.isEnabled = false
            }
        }
        
        // Increment the questions asked counter
        questionsAsked += 1
        
        let options:[String] = currentQuestionAnswer["Options"] as! [String]
        let correctAnswerIndex:Int = currentQuestionAnswer["Answer"] as! Int
        let correctAnswer = options[correctAnswerIndex-1]
        
        if (sender.tag == correctAnswerIndex-1) {
            correctQuestions += 1
            resultLabel.text = "Correct!"
            resultLabel.textColor = UIColor(red: 0/255.0, green: 147/255.0, blue: 135/255.0, alpha: 1.0)
            playCorrectSound()
        } else {
            resultLabel.text = "Sorry, that's not it. Correct Answer is \(correctAnswer)"
            resultLabel.textColor = UIColor(red: 255/255.0, green: 163/255.0, blue: 98/255.0, alpha: 1.0)
            playFailSound()

        }
        resultLabel.isHidden = false
        nextQuestionButton.isHidden = false
       // loadNextRoundWithDelay(seconds: 2)
    }

    @IBAction func nextQuestionAction(_ sender: Any) {
        nextRound()
    }
    
    func nextRound() {
        resultLabel.isHidden = true
        nextQuestionButton.isHidden = true
        
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    @IBAction func playAgain() {
        // Show the answer buttons
        option1Button.isHidden = false
        option2Button.isHidden = false
        option3Button.isHidden = false
        option4Button.isHidden = false
        questionsAsked = 0
        correctQuestions = 0
        nextRound()
    }
    

    
    // MARK: Helper Methods
    
    func loadNextRoundWithDelay(seconds: Int) {
        

        
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }

    
    func loadGameStartSound() {
        let pathToSoundFile1 = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundURL1 = URL(fileURLWithPath: pathToSoundFile1!)
        AudioServicesCreateSystemSoundID(soundURL1 as CFURL, &gameSound)
        
        let pathToSoundFile2 = Bundle.main.path(forResource: "correct", ofType: "wav")
        let soundURL2 = URL(fileURLWithPath: pathToSoundFile2!)
        AudioServicesCreateSystemSoundID(soundURL2 as CFURL, &gameCorrectSound)
        
        let pathToSoundFile3 = Bundle.main.path(forResource: "wrong", ofType: "wav")
        let soundURL3 = URL(fileURLWithPath: pathToSoundFile3!)
        AudioServicesCreateSystemSoundID(soundURL3 as CFURL, &gameFailSound)
        
        
        let pathToSoundFile4 = Bundle.main.path(forResource: "completed", ofType: "wav")
        let soundURL4 = URL(fileURLWithPath: pathToSoundFile4!)
        AudioServicesCreateSystemSoundID(soundURL4 as CFURL, &gameCompletedSound)
        
        
        
        
    }
    func playGameCompletedSound() {
        AudioServicesPlaySystemSound(gameCompletedSound)
    }
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    func playCorrectSound() {
        AudioServicesPlaySystemSound(gameCorrectSound)
    }
    func playFailSound() {
        AudioServicesPlaySystemSound(gameFailSound)
    }
}

