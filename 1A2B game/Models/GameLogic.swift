//
//  GameLogic.swift
//  1A2B game
//
//  Created by 宋宏洋 on 2025/1/26.
//
import SwiftUI


class GameLogic: ObservableObject {
    @Published var answer: [Int]
    @Published var guessHistory: [(guess: String, result: String)] = []
    @Published var currentGuess = ""
    @Published var gameOver = false
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    init() {
        answer = GameLogic.generateAnswer()
    }
    
    static func generateAnswer() -> [Int] {
        var numbers = Array(0...9)
        numbers.shuffle()
        return Array(numbers.prefix(4))
    }
    
    func checkGuess() {
        guard currentGuess.count == 4,
              CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: currentGuess)),
              Set(currentGuess).count == 4 else {
            alertMessage = "請輸入4個不重複的數字"
            showAlert = true
            return
        }
        
        let guessNumbers = currentGuess.map { Int(String($0))! }
        var a = 0
        var b = 0
        
        for (i, num) in guessNumbers.enumerated() {
            if num == answer[i] {
                a += 1
            } else if answer.contains(num) {
                b += 1
            }
        }
        
        let result = "\(a)A\(b)B"
        guessHistory.insert((currentGuess, result), at: 0)
        
        if a == 4 {
            gameOver = true
            alertMessage = "恭喜你猜對了！答案就是 \(currentGuess)"
            showAlert = true
        }
        
        currentGuess = ""
    }
    
    func restart() {
        answer = GameLogic.generateAnswer()
        guessHistory.removeAll()
        currentGuess = ""
        gameOver = false
    }
}
