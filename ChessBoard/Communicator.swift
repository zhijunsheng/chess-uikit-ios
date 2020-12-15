//
//  Communicator.swift
//  ChessBoard
//
//  Created by Golden Thumb on 2020-12-07.
//

import Foundation

class Communicator: NSObject {
    var inputStream: InputStream?
    var outputStream: OutputStream?
    var chessDelegate: ChessDelegate?
    var socketDelegate: SocketDelegate?
    
    func openSocket(serverIP: String, port: Int) {
        var readStream: Unmanaged<CFReadStream>?
        var writeStream: Unmanaged<CFWriteStream>?
        
        CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, serverIP as CFString, UInt32(port), &readStream, &writeStream)
        
        inputStream = readStream!.takeRetainedValue()
        outputStream = writeStream!.takeRetainedValue()
        
        inputStream?.delegate = self
        
        inputStream?.schedule(in: .current, forMode: .common)
        outputStream?.schedule(in: .current, forMode: .common)
        
        inputStream?.open()
        outputStream?.open()
    }
    
    func closeSocket() {
        inputStream?.close()
        outputStream?.close()
    }
    
    func sendMove(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int) {
        let moveStr = "\(fromCol),\(fromRow),\(toCol),\(toRow)\n"
        let data = moveStr.data(using: .utf8)!
        data.withUnsafeBytes {
            guard let pointer = $0.baseAddress?.assumingMemoryBound(to: UInt8.self) else {
                print("error sending chess move")
                return
            }
            outputStream?.write(pointer, maxLength: data.count)
        }
    }
}

extension Communicator: StreamDelegate {
    func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
        switch eventCode {
        case .hasBytesAvailable:
            readAvailableBytes(stream: aStream as! InputStream)
        case .endEncountered:
            print("endEncountered")
            DispatchQueue.main.async {
                self.socketDelegate?.socketClosed()
            }
        case .errorOccurred:
            print("errorOccurred")
            DispatchQueue.main.async {
                self.socketDelegate?.socketClosed()
            }
        case .hasSpaceAvailable:
            print("hasSpaceAvailable")
        case .openCompleted:
            print("openCompleted")
        default:
            print("other event code: \(eventCode)")
        }
    }
    
    private func readAvailableBytes(stream: InputStream) {
        let maxReadLength = 4096
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: maxReadLength)
        while stream.hasBytesAvailable {
            guard let numberOfBytesRead = inputStream?.read(buffer, maxLength: maxReadLength) else {
                return
            }
            if numberOfBytesRead < 0, let error = stream.streamError {
                print(error)
                break
            }
            
            if var msg = processedMessageString(buffer: buffer, length: numberOfBytesRead) {
                if msg.last == "\n" { // in case the msg is like "6,7,7,5\n"
                    msg.removeLast()
                }
                let moveArr = msg.components(separatedBy: ",")
                if let fromCol = Int(moveArr[0]), let fromRow = Int(moveArr[1]), let toCol = Int(moveArr[2]), let toRow = Int(moveArr[3]) {
                    DispatchQueue.main.async {
                        self.chessDelegate?.movePiece(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
                    }
                }
            }
        }
    }
    
    private func processedMessageString(buffer: UnsafeMutablePointer<UInt8>, length: Int) -> String? {
        guard let msg = String(bytesNoCopy: buffer, length: length, encoding: .utf8, freeWhenDone: true) else { return nil }
        return msg
    }
}
