//
//  ChessDelegate.swift
//  ChessBoard
//
//  Created by Golden Thumb on 2020-11-04.
//

import Foundation

protocol ChessDelegate {
    func movePiece(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int)
    func pieceAt(col: Int, row: Int) -> ChessPiece?
}
