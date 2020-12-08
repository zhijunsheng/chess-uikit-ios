//
//  ChessBoard.swift
//  ChessBoard
//
//  Created by Golden Thumb on 2020-11-04.
//

import Foundation

struct ChessBoard {
    var pieceBox: Set<ChessPiece> = []
    
    mutating func initBoard() {
        for i in 0..<2 {
            pieceBox.insert(ChessPiece(col: 0 + i * 7, row: 0, player: .black, imageName: "Rook-black"))
            pieceBox.insert(ChessPiece(col: 1 + i * 5, row: 0, player: .black, imageName: "Knight-black"))
            pieceBox.insert(ChessPiece(col: 2 + i * 3, row: 0, player: .black, imageName: "Bishop-black"))
            
            pieceBox.insert(ChessPiece(col: 0 + i * 7, row: 7, player: .white, imageName: "Rook-white"))
            pieceBox.insert(ChessPiece(col: 1 + i * 5, row: 7, player: .white, imageName: "Knight-white"))
            pieceBox.insert(ChessPiece(col: 2 + i * 3, row: 7, player: .white, imageName: "Bishop-white"))
        }
        
        for i in 0..<8 {
            pieceBox.insert(ChessPiece(col: i, row: 1, player: .black, imageName: "Pawn-black"))
            pieceBox.insert(ChessPiece(col: i, row: 6, player: .white, imageName: "Pawn-white"))
        }
        
        pieceBox.insert(ChessPiece(col: 3, row: 0, player: .black, imageName: "Queen-black"))
        pieceBox.insert(ChessPiece(col: 4, row: 0, player: .black, imageName: "King-black"))
        pieceBox.insert(ChessPiece(col: 3, row: 7, player: .white, imageName: "Queen-white"))
        pieceBox.insert(ChessPiece(col: 4, row: 7, player: .white, imageName: "King-white"))
    }
    
    func pieceAt(col: Int, row: Int) -> ChessPiece? {
        for piece in pieceBox {
            if piece.col == col && piece.row == row {
                return piece
            }
        }
        return nil
    }
    
    mutating func movePiece(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int) {
        guard let movingPiece = pieceAt(col: fromCol, row: fromRow) else { return }
        
        if let targetPiece = pieceAt(col: toCol, row: toRow) {
            if targetPiece.player == movingPiece.player {
                return
            } else {
                pieceBox.remove(targetPiece)
            }
        }
        
        pieceBox.remove(movingPiece)
        pieceBox.insert(ChessPiece(col: toCol, row: toRow, player: movingPiece.player, imageName: movingPiece.imageName))
    }
}
