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
//    static let shared = SocketIOManager() // Singleton으로 관리
    static private var instances: [String: SocketIOManager] = [:]
    private let manager: SocketManager
    private let socket: SocketIOClient
    
    private init(channelId: String) {
        
        let socketURL = URL(string: "\(BaseURL.baseURL)/ws-channel-\(channelId)")!
        manager = SocketManager(socketURL: socketURL, config: [.log(true), .compress])
        socket = manager.defaultSocket
    }
    
    /// 채널별 SocketIOManager 인스턴스 생성 또는 반환
    static func shared(for channelId: String) -> SocketIOManager {
        if let existingInstance = instances[channelId] {
            return existingInstance
        } else {
            let newInstance = SocketIOManager(channelId: channelId)
            instances[channelId] = newInstance
            return newInstance
        }
    }
    
    func connect(channelId: String) -> Completable {
        return Completable.create { [weak self] completable in
            guard let self = self else { return Disposables.create() }
            
            self.socket.on(clientEvent: .connect) { data, ack in
                print("✅ SOCKET CONNECTED: \(data)")
                // 채널 구독 이벤트
//                self.socket.emit("sendMessage", ["channelId": channelId, "content": message])
                completable(.completed)
            }
            
            self.socket.on(clientEvent: .error) { data, ack in
                if let error = data.first as? String {
                    print("❌ SOCKET ERROR: \(error)")
                    completable(.error(SocketError.connectionError(error)))
                }
            }
            
            self.socket.connect()
            
            return Disposables.create {
                self.disconnect()
            }
        }
    }
    
    func disconnect() {
        socket.on(clientEvent: .disconnect) { data, ack in
            print("✅ SOCKET DISCONNECTED: \(data)")
        }
        socket.disconnect()
    }
    
    func listenForMessages() -> Observable<ChannelChatHistoryListResponse> {
        return Observable.create { [weak self] observer in
            guard let self = self else { return Disposables.create() }
            
            self.socket.on("channel") { dataArray, ack in
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
    
    func sendMessage(channelId: String, content: String) -> Completable {
        return Completable.create { [weak self] completable in
            guard let self = self else { return Disposables.create() }

            let message = ["channelId": channelId, "content": content]
            self.socket.emit("sendMessage", message)
            print("📤 MESSAGE SENT: \(message)")

            completable(.completed)
            return Disposables.create()
        }
    }
}

enum SocketError: Error {
    case connectionError(String)
    case invalidData
}
