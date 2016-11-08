//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {


    @IBOutlet weak var hangmanLetterGuess: UITextField!
    @IBOutlet weak var hangmanIncorrectGuesses: UILabel!
    @IBOutlet weak var hangmanImage: UIImageView!
    @IBOutlet weak var hangmanCorrectGuesses: UILabel!
    @IBOutlet weak var startOverButton: UIButton!
    var correctGuesses = ""
    var numIncorrectGuesses: Int = 0
    var phrase = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        phrase = hangmanPhrases.getRandomPhrase()
        hangmanLetterGuess.text = ""
        hangmanIncorrectGuesses.text = ""
        hangmanImage.image = UIImage(named: "hangman1.gif")
        hangmanCorrectGuesses.text = ""
        correctGuesses = ""
        numIncorrectGuesses = 0
        startOverButton.isHidden = true
        
        for char in phrase.characters {
            if char == " " {
                hangmanCorrectGuesses.text = hangmanCorrectGuesses.text! + "  "
                
            } else{
                hangmanCorrectGuesses.text = hangmanCorrectGuesses.text! + "_ "
            }
        }
        print(phrase)
    }
    
    @IBAction func checkHangmanLetter(_ sender: Any) {
        var letterGuessString = hangmanLetterGuess.text
        if (letterGuessString?.characters.count)! == 1
            && hangmanCorrectGuesses.text!.contains("_")
            && (hangmanIncorrectGuesses.text?.characters.count)! < 6 {
            
            if phrase.lowercased().contains(letterGuessString!) {
                correctGuesses = correctGuesses + letterGuessString!
                hangmanCorrectGuesses.text = ""
                for letter in phrase.characters {
                    if correctGuesses.lowercased().contains(String(letter).lowercased()) {
                        hangmanCorrectGuesses.text = hangmanCorrectGuesses.text! + String(letter)
                    }
                    else if letter == " " {
                        hangmanCorrectGuesses.text = hangmanCorrectGuesses.text! + " "
                    }
                    else {
                        hangmanCorrectGuesses.text = hangmanCorrectGuesses.text! + "_ "
                    }
                }
                
                if (!(hangmanCorrectGuesses.text?.contains("_"))!){
                    startOverButton.isHidden = false
                    
                    let alertController = UIAlertController(title: "You win", message: "You're ok, n00b.", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
                    alertController.addAction(defaultAction)
                    present(alertController, animated: true, completion: nil)
                }
            }
            
            else {
                numIncorrectGuesses += 1
                hangmanIncorrectGuesses.text = hangmanIncorrectGuesses.text! + letterGuessString!
                
                switch numIncorrectGuesses {
                case 1:
                    hangmanImage.image = UIImage(named: "hangman2.gif")
                case 2:
                    hangmanImage.image = UIImage(named: "hangman3.gif")
                case 3:
                    hangmanImage.image = UIImage(named: "hangman4.gif")
                case 4:
                    hangmanImage.image = UIImage(named: "hangman5.gif")
                case 5:
                    hangmanImage.image = UIImage(named: "hangman6.gif")
                case 6:
                    hangmanImage.image = UIImage(named: "hangman7.gif")
                default: break   
                }
                
                if hangmanIncorrectGuesses.text?.characters.count == 6 {
                    startOverButton.isHidden = false
                    
                    let alertController = UIAlertController(title: "You lose", message: "You suck, n00b.", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
                    alertController.addAction(defaultAction)
                    present(alertController, animated: true, completion: nil)
                }
            }
        }
        hangmanLetterGuess.text = ""
    }
    
    @IBAction func startOver(_ sender: Any) {
        viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
