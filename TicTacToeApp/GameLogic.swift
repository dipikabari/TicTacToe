//
//  GameLogic.swift
//  TicTacToeApp
//
//  Created by Dipika Bari on 19/12/2024.
//

import Foundation

enum Player {
    case X
    case O
}

class TicTacModel: ObservableObject {
    @Published var board: [Player?] = Array(repeating: nil, count: 9)
    @Published var activePlayer: Player = .X
    @Published var winner: Player? = nil
    
    var isDraw: Bool {
        return winner == nil && board.allSatisfy { $0 != nil }
    }
    
    // Button pressed
    func buttonTap(on index: Int) {
        guard board[index] == nil && winner == nil else {
            return
        }

        board[index] = activePlayer
        
        if checkWinner() {
            winner = activePlayer
        } else {
            activePlayer = (activePlayer == .X) ? .O : .X
        }
    }
    
    // Button Label
    func buttonLabel(at index: Int) -> String {
        if let player = board[index] {
            return player == .X ? "X" : "O"
        }
         return ""
    }
    
    // Reset the game
    func resetGame() {
        board = Array(repeating: nil, count: 9)
        activePlayer = .X
        winner = nil
    }
    
    // Determine Winner
    func checkWinner() -> Bool {
        // Check rows
        for i in stride(from: 0, to: 9, by: 3) {
            if board[i] == activePlayer && board[i+1] == activePlayer && board[i+2] == activePlayer {
                return true
            }
        }
        // Check columns
        for i in 0..<3 {
            if board[i] == activePlayer && board[i+3] == activePlayer && board[i+6] == activePlayer {
                return true
            }
        }
        
        // Check diagonals
        if board[0] == activePlayer && board[4] == activePlayer && board[8] == activePlayer {
            return true
        }
        
        if board[2] == activePlayer && board[4] == activePlayer && board[6] == activePlayer {
            return true
        }
        
        return false
    }
}
