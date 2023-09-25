//
//  ViewController.swift
//  TicTacToe
//
//  Created by PraDeePKuMaR RaJaRaM on 22/09/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var turn: UILabel!
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    enum Turn {
        case Cross
        case Nought
    }
    
    var firstTurn = Turn.Cross
    var currentTurn = Turn.Cross
    var Nought = "O"
    var Cross = "X"
    var board = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBoard()
        for button in board {
            button.setTitle("", for: .normal)
        }
    }
     
    @IBAction func addToBoard(_ sender: UIButton) {
        add(sender)
        if checkVictory(Cross) {
            resultAlert(title: "X win")
        }
        if checkVictory(Nought) {
            resultAlert(title: "O win")
        }
        if fullBoard() {
            resultAlert(title: "Draw")
        }
    }
    
    func initBoard() {
        board.append(a1)
        board.append(a2)
        board.append(a3)
        board.append(b1)
        board.append(b2)
        board.append(b3)
        board.append(c1)
        board.append(c2)
        board.append(c3)
    }
    
    func fullBoard() -> Bool {
        for button in board {
            if button.title(for: .normal) == "" {
                return false
            }
        }
        return true
    }
    
    func add(_ sender: UIButton) {
        if sender.title(for: .normal) == "" {
            if currentTurn == Turn.Nought {
                sender.setTitle(Nought, for: .normal)
                currentTurn = Turn.Cross
                turn.text = Cross
            } else if currentTurn == Turn.Cross {
                sender.setTitle(Cross, for: .normal)
                sender.tintColor = .red
                currentTurn = Turn.Nought
                turn.text = Nought
            }
            sender.isEnabled = false
        }
    }
    
    func checkVictory(_ s: String) -> Bool {
        //Horizontal
        if thisSymbol(a1, s) && thisSymbol(a2, s) && thisSymbol(a3, s) {
            return true
        }
        if thisSymbol(b1, s) && thisSymbol(b2, s) && thisSymbol(b3, s) {
            return true
        }
        if thisSymbol(c1, s) && thisSymbol(c2, s) && thisSymbol(c3, s) {
            return true
        }
        //Vertical
        if thisSymbol(a1, s) && thisSymbol(b1, s) && thisSymbol(c1, s) {
            return true
        }
        if thisSymbol(a2, s) && thisSymbol(b2, s) && thisSymbol(c2, s) {
            return true
        }
        if thisSymbol(a3, s) && thisSymbol(b3, s) && thisSymbol(c3, s) {
            return true
        }
        //Diagonal
        if thisSymbol(a1, s) && thisSymbol(b2, s) && thisSymbol(c3, s) {
            return true
        }
        if thisSymbol(a3, s) && thisSymbol(b2, s) && thisSymbol(c1, s) {
            return true
        }
        return false
    }
    
    func thisSymbol(_ button: UIButton, _ s: String) -> Bool {
        return button.title(for: .normal) == s
    }
    
    func resultAlert(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        let reset = UIAlertAction(title: "Reset", style: .default, handler: { _ in
            self.resetBoard()
        })
        alert.addAction(reset)
        self.present(alert, animated: true)
    }
    
    func resetBoard() {
        for button in board {
            button.setTitle("", for: .normal)
            button.isEnabled = true
        }
        if firstTurn == Turn.Cross {
            firstTurn = Turn.Nought
            turn.text = Nought
        } else if firstTurn == Turn.Nought {
            firstTurn = Turn.Cross
            turn.text = Cross
        }
        currentTurn = firstTurn
    }
}

