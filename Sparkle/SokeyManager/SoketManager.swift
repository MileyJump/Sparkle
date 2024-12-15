//
//  SoketManager.swift
//  Sparkle
//
//  Created by 최민경 on 12/12/24.
//

import Foundation
import SocketIO
import RxSwift

final class SocketIOManager {

    private let manager: SocketManager
    private let socket: SocketIOClient
    
    init(channelId: String) {
        
        let socketURL = URL(string: BaseURL.baseURL)!
        
        manager = SocketManager(socketURL: socketURL, config: [.log(true), .compress])
        socket = manager.socket(forNamespace: "/ws-channel-\(channelId)")
    }
    
//    
//    func connect(channelId: String) -> Completable {
//        return Completable.create { [weak self] completable in
//            guard let self = self else {
//                return Disposables.create()
//            }
//            
//            // 먼저 소켓 연결
//            self.socket.connect()
//
//            // 소켓 연결 이벤트 리스너 등록
//            self.socket.on(clientEvent: .connect) { data, ack in
//                print("✅ SOCKET CONNECTED: \(data)")
//                completable(.completed)
//            }
//            
//            // 에러 이벤트 리스너 등록
//            self.socket.on(clientEvent: .error) { data, ack in
//                if let error = data.first as? String {
//                    print("❌ SOCKET ERROR: \(error)")
//                    completable(.error(SocketError.connectionError(error)))
//                }
//            }
//            
//            // 연결 후 해제할 리소스 설정
//            return Disposables.create {
//                self.disconnect()
//            }
//        }
//    }
    
    func connect(channelId: String)  {
        
        // 소켓 연결 이벤트 리스너 등록 (연결 전에 미리 등록)
        self.socket.on(clientEvent: .connect) { data, ack in
            print("✅ SOCKET CONNECTED: \(data)✅! \(ack)")
        }
        // 소켓 연결
        self.socket.connect()
}
    
    func disconnect() {
        socket.on(clientEvent: .disconnect) { data, ack in
            print("✅ SOCKET DISCONNECTED: \(data) ✅! \(ack)")
        }
        socket.disconnect()
    }
    
    func listenForMessages() -> Observable<ChannelChatHistoryListResponse> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create() }
            
            self.socket.on("channel") {
                dataArray, ack in
                print("📩 RECEIVED MESSAGE: \(dataArray)")
                guard let data = dataArray.first as? [String: Any] else {
                    observer.onError(SocketError.invalidData)
                    return
                }
                
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                    let message = try JSONDecoder().decode(ChannelChatHistoryListResponse.self, from: jsonData)
                    observer.onNext(message)
                } catch {
                    print("❌ MESSAGE PARSE ERROR: \(error)")
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}

enum SocketError: Error {
    case connectionError(String)
    case invalidData
}
