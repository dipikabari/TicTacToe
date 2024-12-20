//
//  ContentView.swift
//  TicTacToeApp
//
//  Created by Dipika Bari on 19/12/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var ticTac =  TicTacModel()
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
            ScrollView {
                VStack {
                    Text("TIC TAC TOE")
                        .font(.system(size: 40, weight:  .heavy))
                        .foregroundColor(.purple)
                    
                    let column = Array(repeating: GridItem(.flexible()), count: 3)
                    
                    LazyVGrid(columns: column, content: {
                        ForEach(0..<9) { index in
                            Button(action: {
                                ticTac.buttonTap(on: index)
                                if ticTac.winner != nil {
                                    alertMessage = "Winner is \(ticTac.winner == .X ? "Player X" : "Player O")!"
                                    showAlert = true
                                } else if ticTac.isDraw {
                                    alertMessage = "Its a draw!!"
                                    showAlert = true
                                }
                            }, label: {
                                Text(ticTac.buttonLabel(at: index))
                                    .frame(width: 100, height:  100)
                                    .background(.blue)
                                    .foregroundStyle(.white)
                                    .font(.system(size: 45, weight: .bold, design: .default))
                                    .cornerRadius(10)
                            })
                        }
                    })
                    .padding(.bottom)
                    
                    Button(action: {
                        ticTac.resetGame()
                    }, label: {
                        Text("RESTART GAME")
                            .frame(width: 200, height:  50)
                            .background(.purple)
                            .foregroundStyle(.white)
                            .font(.system(size: 20, weight: .semibold, design: .monospaced))
                            .clipShape(Capsule())
                    })
                    .padding(.top)
                    
                }
                .padding()
                
                .overlay(
                    ZStack {
                        if showAlert {
                            Color.black.opacity(0.6)
                                .edgesIgnoringSafeArea(.all)
                            
                            VStack(spacing: 20) {
                                Text("Game Over")
                                    .font(.system(size: 50, weight: .bold, design: .rounded))
                                    .foregroundColor(.blue)
                                
                                Text(alertMessage)
                                    .font(.system(size: 30, weight: .semibold, design: .default))
                                    .foregroundColor(.purple)
                                
                                Button(action: {
                                    showAlert = false
                                    ticTac.resetGame()
                                }, label: {
                                    Text("Play Again!")
                                        .frame(width: 200, height: 40)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .font(.system(size: 20, weight: .bold))
                                        .cornerRadius(10)
                                })
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(radius: 10)
                        }
                    }
                )
            }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
