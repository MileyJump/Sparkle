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
    
    func join(query: JoinQuery) -> Single<UserResponse> {
        return Single.create { [weak self] single in
            self?.userProvider.request(.join(query)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decodedData = try JSONDecoder().decode(UserResponse.self, from: response.data)
                        single(.success(decodedData))
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
    
//    func emailValidation(query: EmailValidationQuery) -> Single<EmailValidationReponse> {
//        return Single.create { [weak self] single in
//            self?.userProvider.request(.emailValidation(query)) { result in
//                switch result {
//                case .success(let response):
//                    do {
//                        let decodedData = try JSONDecoder().decode(EmailValidationReponse.self, from: response.data)
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
        
        func login(query: LoginQuery) -> Single<UserResponse> {
            return Single.create { [weak self] single in
                self?.userProvider.request(.login(query)) { result in
                    switch result {
                    case .success(let response):
                        do {
                            let decodedData = try JSONDecoder().decode(UserResponse.self, from: response.data)
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
    
    func kakaoLogin(query: KakaoLoginQuery) -> Single<UserResponse> {
        return Single.create { [weak self] single in
            self?.userProvider.request(.kakaoLogin(query)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decodedData = try JSONDecoder().decode(UserResponse.self, from: response.data)
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
    
    func appleLogin(query: AppleLoginQuery) -> Single<UserResponse> {
        return Single.create { [weak self] single in
            self?.userProvider.request(.appleLogin(query)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decodedData = try JSONDecoder().decode(UserResponse.self, from: response.data)
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
    
    // logout
    
//    func DeviceToken(query: DeviceTokenQuery) -> Single<DeviceTokenResponse> {
//        return Single.create { [weak self] single in
//            self?.userProvider.request(.deviceToken(query)) { result in
//                switch result {
//                case .success(let response):
//                    do {
//                        let decodedData = try JSONDecoder().decode(DeviceTokenResponse.self, from: response.data)
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
    
    func profileCheck(query: ProfileCheckQuery) -> Single<UserResponse> {
        return Single.create { [weak self] single in
            self?.userProvider.request(.profileCheck(query)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decodedData = try JSONDecoder().decode(UserResponse.self, from: response.data)
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
    
    func profileModification(query: ProfileModificationQuery) -> Single<UserResponse> {
        return Single.create { [weak self] single in
            self?.userProvider.request(.profileModification(query)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decodedData = try JSONDecoder().decode(UserResponse.self, from: response.data)
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
    
    func profileImage() { }
    
    func userprofileCheck(query: UserprofileCheckQuery) -> Single<UserMemberResponse> {
        return Single.create { [weak self] single in
            self?.userProvider.request(.userProfileCheck(query)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decodedData = try JSONDecoder().decode(UserResponse.self, from: response.data)
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
}
