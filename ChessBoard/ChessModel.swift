//
//  ChessModel.swift
//  ChessModel
//
//  Created by Golden Thumb on 2020-11-04.
//

import Foundation

struct ChessModel {
    var piecesBox: Set<ChessPiece> = []
    
    mutating func initBoard() {
        piecesBox.removeAll()
        
        for i in 0..<2 {
            piecesBox.insert(ChessPiece(col: 0 + i * 7, row: 7, player: .black, imageName: "Rook-black"))
            piecesBox.insert(ChessPiece(col: 1 + i * 5, row: 7, player: .black, imageName: "Knight-black"))
            piecesBox.insert(ChessPiece(col: 2 + i * 3, row: 7, player: .black, imageName: "Bishop-black"))
            
            piecesBox.insert(ChessPiece(col: 0 + i * 7, row: 0, player: .white, imageName: "Rook-white"))
            piecesBox.insert(ChessPiece(col: 1 + i * 5, row: 0, player: .white, imageName: "Knight-white"))
            piecesBox.insert(ChessPiece(col: 2 + i * 3, row: 0, player: .white, imageName: "Bishop-white"))
        }
        
        for i in 0..<8 {
            piecesBox.insert(ChessPiece(col: i, row: 6, player: .black, imageName: "Pawn-black"))
            piecesBox.insert(ChessPiece(col: i, row: 1, player: .white, imageName: "Pawn-white"))
        }
        
        piecesBox.insert(ChessPiece(col: 3, row: 7, player: .black, imageName: "Queen-black"))
        piecesBox.insert(ChessPiece(col: 4, row: 7, player: .black, imageName: "King-black"))
        piecesBox.insert(ChessPiece(col: 3, row: 0, player: .white, imageName: "Queen-white"))
        piecesBox.insert(ChessPiece(col: 4, row: 0, player: .white, imageName: "King-white"))
    }
    
    func pieceAt(col: Int, row: Int) -> ChessPiece? {
        for piece in piecesBox {
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
                piecesBox.remove(targetPiece)
            }
        }
        
        piecesBox.remove(movingPiece)
        piecesBox.insert(ChessPiece(col: toCol, row: toRow, player: movingPiece.player, imageName: movingPiece.imageName))
    }
}
