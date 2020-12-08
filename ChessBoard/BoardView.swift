//
//  BoardView.swift
//  ChessBoard
//
//  Created by Golden Thumb on 2020-10-22.
//

import UIKit

class BoardView: UIView {
    var shadowPieceBox: Set<ChessPiece> = []
    var cellSide: CGFloat = 0
    var fromCol: Int = -1
    var fromRow: Int = -1
    var chessDelegate: ChessDelegate?
    var movingPiece: ChessPiece?
    var fingerLocationX: CGFloat = -1
    var fingerLocationY: CGFloat = -1

    override func draw(_ rect: CGRect) {
        cellSide = bounds.width / 8
        
        drawBoard()
        drawPieces()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let first = touches.first!
        let fingerLocation = first.location(in: self)
        fromCol = Int(fingerLocation.x / cellSide)
        fromRow = 7 - Int(fingerLocation.y / cellSide)
        
        movingPiece = chessDelegate?.pieceAt(col: fromCol, row: fromRow)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let first = touches.first!
        let fingerLocation = first.location(in: self)
        let toCol: Int = Int(fingerLocation.x / cellSide)
        let toRow: Int = 7 - Int(fingerLocation.y / cellSide)
        chessDelegate?.movePiece(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
        movingPiece = nil
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let first = touches.first!
        let fingerLocation = first.location(in: self)
        fingerLocationX = fingerLocation.x
        fingerLocationY = fingerLocation.y
        setNeedsDisplay()
    }
    
    func drawPieces() {
        for piece in shadowPieceBox where piece != movingPiece {
            drawPieceAt(col: piece.col, row: piece.row, imageName: piece.imageName)
        }
        
        if let movingPiece = movingPiece {
            let pieceImage = UIImage(named: movingPiece.imageName)
            pieceImage?.draw(in: CGRect(x: fingerLocationX - cellSide/2, y: fingerLocationY - cellSide/2, width: cellSide, height: cellSide))
        }
    }
    
    func drawPieceAt(col: Int, row: Int, imageName: String) {
        let pawnImage = UIImage(named: imageName)
        pawnImage?.draw(in: CGRect(x: CGFloat(col) * cellSide, y: CGFloat(7 - row) * cellSide, width: cellSide, height: cellSide))
    }
    
    func drawBoard() {
        drawTwoRows(startingRow: 0)
        drawTwoRows(startingRow: 2)
        drawTwoRows(startingRow: 4)
        drawTwoRows(startingRow: 6)
    }
    
    func drawTwoRows(startingRow: Int) {
        UIColor.gray.setFill()
        
        UIBezierPath(rect: CGRect(x: 1 * cellSide, y: CGFloat(startingRow) * cellSide, width: cellSide, height: cellSide)).fill()
        UIBezierPath(rect: CGRect(x: 3 * cellSide, y: CGFloat(startingRow) * cellSide, width: cellSide, height: cellSide)).fill()
        UIBezierPath(rect: CGRect(x: 5 * cellSide, y: CGFloat(startingRow) * cellSide, width: cellSide, height: cellSide)).fill()
        UIBezierPath(rect: CGRect(x: 7 * cellSide, y: CGFloat(startingRow) * cellSide, width: cellSide, height: cellSide)).fill()
        
        UIBezierPath(rect: CGRect(x: 0 * cellSide, y: CGFloat(startingRow + 1) * cellSide, width: cellSide, height: cellSide)).fill()
        UIBezierPath(rect: CGRect(x: 2 * cellSide, y: CGFloat(startingRow + 1) * cellSide, width: cellSide, height: cellSide)).fill()
        UIBezierPath(rect: CGRect(x: 4 * cellSide, y: CGFloat(startingRow + 1) * cellSide, width: cellSide, height: cellSide)).fill()
        UIBezierPath(rect: CGRect(x: 6 * cellSide, y: CGFloat(startingRow + 1) * cellSide, width: cellSide, height: cellSide)).fill()
    }

}
