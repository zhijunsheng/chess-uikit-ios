//
//  SocketDelegate.swift
//  ChessBoard
//
//  Created by Golden Thumb on 2020-12-15.
//

import Foundation

protocol SocketDelegate {
    func socketClosed()
    func moveReceived(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int)
}
