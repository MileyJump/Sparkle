//
//  UserNetworkManager.swift
//  Sparkle
//
//  Created by 최민경 on 11/20/24.
//

import Foundation
import Moya
import RxSwift


enum CustomError: Error {
    case clientError(errorCode: String, message: String?)
    case serverError
    case unknown
}

// 응답 데이터에서 errorCode 파싱을 위한 구조체 정의
struct ErrorResponse: Decodable {
    let errorCode: String
    let errorMessage: String?
}

final class UserNetworkManager {
  
    static let shared = UserNetworkManager()
    private let userProvider: MoyaProvider<UserAPI>
    
    private init() {
        self.userProvider = MoyaProvider<UserAPI>(plugins: [NetworkLoggerPlugin()])
        
    }
    
    func request<T: Decodable>(_ target: UserAPI, responseType: T.Type) -> Single<T> {
        return Single.create { [weak self] single in
            self?.userProvider.request(target) { result in
                switch result {
                case .success(let response):
                    do {
                        let statusCode = response.statusCode
                        
                       
                        
                        switch statusCode {
                        case 200...299:
                            if T.self == VoidResponse.self {
                                single(.success(VoidResponse() as! T)) // Void 반환 처리
                            } else {
                                let decodedData = try JSONDecoder().decode(T.self, from: response.data)
                                single(.success(decodedData))
                            }
                        case 400...499:
                            // 클라이언트 에러 처리
                            let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: response.data)
                            if let errorCode = errorResponse?.errorCode {
                                single(.failure(CustomError.clientError(errorCode: errorCode, message: errorResponse?.errorMessage)))
                            } else {
                                single(.failure(CustomError.unknown))
                            }
                        case 500...599:
                            // 서버 에러 처리
                            single(.failure(CustomError.serverError))
                        default:
                            single(.failure(CustomError.unknown))
                        }
                    } catch {
                        single(.failure(error)) // 디코딩 에러
                    }
                case .failure(let error):
                    single(.failure(error)) // 네트워크 실패
                }
            }
            return Disposables.create()
        }
    }
    
//    func request<T: Decodable>(_ target: UserAPI, responseType: T.Type) -> Single<T> {
//        return Single.create { [weak self] single in
//            self?.userProvider.request(target) { result in
//                switch result {
//                case .success(let response):
//                    do {
//                        print("===============================\(response.statusCode)")
//                        if T.self == VoidResponse.self {
//                            single(.success(VoidResponse() as! T)) // Void를 반환
//                        } else {
//                            let decodedData = try JSONDecoder().decode(T.self, from: response.data)
//                            single(.success(decodedData))
//                            
//                        }
//                    } catch {
//                        single(.failure(error))
//                    }
//                case .failure(let error):
//                    single(.failure(error))
//                }
//            }
//            return Disposables.create()
//        }
//    }
 
    func join(query: JoinQuery) -> Single<UserResponse> {
        return request(.join(query), responseType: UserResponse.self)
    }
    
    func emailValidation(query: EmailValidationQuery) -> Single<Void> {
        return request(.emailValidation(query), responseType: VoidResponse.self).map { _ in }
    }

    func login(query: LoginQuery) -> Single<UserResponse> {
        return request(.login(query), responseType: UserResponse.self)
    }

    func kakaoLogin(query: KakaoLoginQuery) -> Single<UserResponse> {
        return request(.kakaoLogin(query), responseType: UserResponse.self)
    }


    func appleLogin(query: AppleLoginQuery) -> Single<UserResponse> {
        return request(.appleLogin(query), responseType: UserResponse.self)
    }
    
    func logout() -> Single<Void> {
        return request(.logout, responseType: VoidResponse.self).map { _ in }
    }
    
    func DeviceToken(query: DeviceTokenQuery) -> Single<()> {
        return request(.deviceToken(query), responseType: VoidResponse.self).map { _ in }
    }

    func profileCheck(query: ProfileCheckQuery) -> Single<UserResponse> {
        return request(.profileCheck(query), responseType: UserResponse.self)
    }

    func profileModification(query: ProfileModificationQuery) -> Single<UserResponse> {
        return request(.profileModification(query), responseType: UserResponse.self)
    }
    
    func ProfileImageModification(query: ProfileImageModificationQuery) -> Single<UserResponse> {
        return request(.profileImageModification(query), responseType: UserResponse.self)
    }
    
    func userProfileCheck(query: UserprofileCheckQuery) -> Single<UserMemberResponse> {
        return request(.userProfileCheck(query), responseType: UserMemberResponse.self)
    }
}
