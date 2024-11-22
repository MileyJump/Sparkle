//
//  UserNetworkManager.swift
//  Sparkle
//
//  Created by 최민경 on 11/20/24.
//

import Foundation
import Moya
import RxSwift

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
                        if T.self == VoidResponse.self {
                            single(.success(VoidResponse() as! T)) // Void를 반환
                        } else {
                            let decodedData = try JSONDecoder().decode(T.self, from: response.data)
                            single(.success(decodedData))
                        }
                    } catch {
                        single(.failure(error))
                    }
                case .failure(let error):
                    single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
 
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
