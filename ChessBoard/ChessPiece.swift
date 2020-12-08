//
//  ChessPiece.swift
//  ChessBoard
//
//  Created by Golden Thumb on 2020-11-01.
//

import Foundation

struct ChessPiece: Hashable {
    let col: Int
    let row: Int
    let player: ChessPlayer
    let imageName: String
}
