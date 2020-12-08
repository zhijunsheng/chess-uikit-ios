//
//  ViewController.swift
//  ChessBoard
//
//  Created by Golden Thumb on 2020-10-22.
//

import UIKit

class ViewController: UIViewController, ChessDelegate {

    var chessBoard = ChessBoard()
    @IBOutlet weak var boardView: BoardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        boardView.chessDelegate = self
        
        chessBoard.initBoard()
        boardView.shadowPieceBox = chessBoard.pieceBox
        boardView.setNeedsDisplay()
    }

    func movePiece(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int) {
        chessBoard.movePiece(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
        boardView.shadowPieceBox = chessBoard.pieceBox
        boardView.setNeedsDisplay()
    }
    
    func pieceAt(col: Int, row: Int) -> ChessPiece? {
        return chessBoard.pieceAt(col: col, row: row)
    }
}

/*
 
 macOS Cocoa
 macOS SwiftUI
 
 * iOS UIKit
 iOS SwiftUI
 
 */
