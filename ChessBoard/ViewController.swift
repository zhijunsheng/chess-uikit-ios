//
//  ViewController.swift
//  ChessBoard
//
//  Created by Golden Thumb on 2020-10-22.
//

import UIKit

class ViewController: UIViewController, ChessDelegate {
    let communicator = Communicator()
    var chessBoard = ChessModel()
    
    @IBOutlet weak var boardView: BoardView!
    @IBOutlet weak var connectButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        boardView.chessDelegate = self
        
        chessBoard.initBoard()
        boardView.shadowPieceBox = chessBoard.pieceBox
        boardView.setNeedsDisplay()
    }
    
    @IBAction func reset(_ sender: UIButton) {
        chessBoard.initBoard()
        boardView.shadowPieceBox = chessBoard.pieceBox
        boardView.setNeedsDisplay()
        
        communicator.closeSocket()
        connectButton.isEnabled = true
    }
    
    @IBAction func connect(_ sender: UIButton) {
        communicator.chessDelegate = self
        communicator.openSocket()
        connectButton.isEnabled = false
    }
    
    func movePiece(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int) {
        chessBoard.movePiece(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
        boardView.shadowPieceBox = chessBoard.pieceBox
        boardView.setNeedsDisplay()
        
        communicator.sendMove(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
    }
    
    func pieceAt(col: Int, row: Int) -> ChessPiece? {
        return chessBoard.pieceAt(col: col, row: row)
    }
}
