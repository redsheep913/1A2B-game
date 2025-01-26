//
//  ContentView.swift
//  1A2B game
//
//  Created by 宋宏洋 on 2025/1/26.
//
import SwiftUI

struct ContentView: View {
    @StateObject private var game = GameLogic()
    
    // 定義莫蘭迪配色
    private let colors = CustomColors()
    
    let keypadNumbers = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        ["Clear", "0", "Delete"]
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                colors.background
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Text("1A2B 猜數字遊戲")
                        .font(.title)
                        .bold()
                        .foregroundColor(colors.text)
                    
                    // Current guess display
                    HStack(spacing: 15) {
                        ForEach(0..<4) { index in
                            Text(index < game.currentGuess.count ? String(game.currentGuess[game.currentGuess.index(game.currentGuess.startIndex, offsetBy: index)]) : "_")
                                .font(.system(size: 24, weight: .bold))
                                .frame(width: 45, height: 45)
                                .background(colors.inputBackground)
                                .cornerRadius(10)
                                .foregroundColor(colors.text)
                        }
                    }
                    
                    // Guess button
                    Button(action: game.checkGuess) {
                        Text("猜!")
                            .padding(.horizontal, 30)
                            .padding(.vertical, 10)
                            .background(colors.primary)
                            .foregroundColor(colors.buttonText)
                            .cornerRadius(10)
                    }
                    .disabled(game.gameOver || game.currentGuess.count != 4)
                    
                    // History list
                    List(game.guessHistory, id: \.guess) { item in
                        HStack {
                            Text(item.guess)
                                .foregroundColor(colors.text)
                            Spacer()
                            Text(item.result)
                                .foregroundColor(colors.accent)
                        }
                        .listRowBackground(colors.cellBackground)
                    }
                    .scrollContentBackground(.hidden)
                    
                    // Number keypad
                    VStack(spacing: 10) {
                        ForEach(keypadNumbers, id: \.self) { row in
                            HStack(spacing: 10) {
                                ForEach(row, id: \.self) { number in
                                    Button(action: {
                                        handleKeypadInput(number)
                                    }) {
                                        Text(number)
                                            .font(.title2)
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 45)
                                            .background(getKeypadButtonColor(number))
                                            .foregroundColor(colors.buttonText)
                                            .cornerRadius(10)
                                    }
                                    .disabled(shouldDisableButton(number))
                                }
                            }
                        }
                    }
                    .padding()
                    
                    Button("重新開始") {
                        game.restart()
                    }
                    .padding()
                    .background(colors.secondary)
                    .foregroundColor(colors.buttonText)
                    .cornerRadius(10)
                }
                .padding()
            }
            .alert(isPresented: $game.showAlert) {
                Alert(
                    title: Text("提示"),
                    message: Text(game.alertMessage),
                    dismissButton: .default(Text("確定"))
                )
            }
        }
    }
    
    private func handleKeypadInput(_ number: String) {
        switch number {
        case "Clear":
            game.currentGuess = ""
        case "Delete":
            if !game.currentGuess.isEmpty {
                game.currentGuess.removeLast()
            }
        default:
            if game.currentGuess.count < 4 && !game.currentGuess.contains(number) {
                game.currentGuess += number
            }
        }
    }
    
    private func shouldDisableButton(_ number: String) -> Bool {
        if game.gameOver { return true }
        if number == "Clear" || number == "Delete" { return false }
        return game.currentGuess.count >= 4 || game.currentGuess.contains(number)
    }
    
    private func getKeypadButtonColor(_ number: String) -> Color {
        switch number {
        case "Clear":
            return colors.clearButton
        case "Delete":
            return colors.deleteButton
        default:
            return colors.numberButton
        }
    }
}

struct CustomColors {
    let background = Color(red: 0.96, green: 0.95, blue: 0.93)     // 米白底色
    let primary = Color(red: 0.65, green: 0.35, blue: 0.30)        // 深磚紅
    let secondary = Color(red: 0.82, green: 0.71, blue: 0.65)      // 淺褐色
    let accent = Color(red: 0.55, green: 0.40, blue: 0.35)         // 暗褐色
    let numberButton = Color(red: 0.75, green: 0.70, blue: 0.65)   // 灰褐色
    let clearButton = Color(red: 0.85, green: 0.75, blue: 0.70)    // 淺米色
    let deleteButton = Color(red: 0.70, green: 0.65, blue: 0.60)   // 深灰褐
    let text = Color(red: 0.35, green: 0.30, blue: 0.25)          // 深褐文字
    let buttonText = Color.white                                   // 按鈕文字
    let inputBackground = Color(red: 0.90, green: 0.88, blue: 0.85) // 輸入框底色
    let cellBackground = Color(red: 0.93, green: 0.91, blue: 0.89) // 列表單元格底色
}

#Preview {
    ContentView()
}
