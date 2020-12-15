//
//  ViewController.swift
//  ChessBoard
//
//  Created by Golden Thumb on 2020-10-22.
//

import UIKit

class ChessViewController: UIViewController {
    let communicator = Communicator()
    var chessBoard = ChessModel()
    
    @IBOutlet weak var boardView: BoardView!
    @IBOutlet weak var connectButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        boardView.chessDelegate = self
        
        chessBoard.initBoard()
        boardView.setNeedsDisplay()
    }
    
    @IBAction func reset(_ sender: UIButton) {
        chessBoard.initBoard()
        boardView.setNeedsDisplay()
        
        communicator.closeSocket()
        connectButton.isEnabled = true
    }
    
    @IBAction func connect(_ sender: UIButton) {
        let alert = UIAlertController(title: "Socket Server", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.text = "127.0.0.1"
            textField.keyboardType = .URL
        }
        alert.addTextField { textField in
            textField.text = "50000"
            textField.keyboardType = .numberPad
        }
        alert.addAction(UIAlertAction(title: "Cancle", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Connect", style: .default, handler: { alertAction in
            if let serverIP = alert.textFields?.first?.text, let portStr = alert.textFields?.last?.text, let port = Int(portStr) {
                self.communicator.chessDelegate = self
                self.communicator.socketDelegate = self
                self.communicator.openSocket(serverIP: serverIP, port: port)
                self.connectButton.isEnabled = false
            }
        }))
        present(alert, animated: true, completion: nil)
    }
}

extension ChessViewController: SocketDelegate {
    func socketClosed() {
        print("socket closed")
        let alert = UIAlertController(title: "Socket closed", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension ChessViewController: ChessDelegate {
    func movePiece(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int) {
        chessBoard.movePiece(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
        boardView.setNeedsDisplay()
        
        communicator.sendMove(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
    }
    
    func pieceAt(col: Int, row: Int) -> ChessPiece? {
        return chessBoard.pieceAt(col: col, row: row)
    }
}
