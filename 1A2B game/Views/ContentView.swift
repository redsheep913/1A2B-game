//
//  ContentView.swift
//  1A2B game
//
//  Created by 宋宏洋 on 2025/1/26.
//

import SwiftUI


struct ContentView: View {
    @StateObject private var game = GameLogic()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("1A2B 猜數字遊戲")
                    .font(.title)
                    .bold()
                
                HStack {
                    TextField("輸入4個不重複數字", text: $game.currentGuess)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .disabled(game.gameOver)
                    
                    Button(action: game.checkGuess) {
                        Text("猜!")
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .disabled(game.gameOver)
                }
                .padding(.horizontal)
                
                List(game.guessHistory, id: \.guess) { item in
                    HStack {
                        Text(item.guess)
                        Spacer()
                        Text(item.result)
                            .foregroundColor(.blue)
                    }
                }
                
                Button("重新開始") {
                    game.restart()
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)
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
}

#Preview {
    ContentView()
}
