# 🎇 Sparkle (스파클)

 **다양한 사람들과 커뮤니케이션 혹은 협업을 위한 소통 플랫폼**
 <br/>

 <p align="center">
  <img src="https://github.com/user-attachments/assets/51c8d18f-514c-45ee-b87d-224c504c2380" alt="Group 726" width="200"/>
</p>
 
## 프로젝트 소개

*"**Sparkle**은 메세지를 주고 받으며 소통하고, 그 과정에서 새로운 아이디어가 반짝이는 순간을 만들어가길 바라는 마음을 담았습니다."*  

> 개발 기간 : 2024. 11. 14 ~ 24. 12. 15 (약 1달) <br/> 
> 개발 인원 : 1명 <br/> 
> 최소 버전 : iOS 16.6 +

<p align="center">
  <img src="https://github.com/user-attachments/assets/f6114730-acc7-4a19-a6d3-aba651096fac" width="200"/>
  <img src="https://github.com/user-attachments/assets/3d344c64-fda1-49ae-9bc3-d9f9933558f4" width="200"/>
  <img src="https://github.com/user-attachments/assets/5268bedb-9154-4db6-b7a0-75f158e58778" width="200"/>
</p>

<p align="center">
 <img src="https://github.com/user-attachments/assets/3158e791-a5dd-4e15-813b-077ce7adfdea" width="200"/>
 <img src="https://github.com/user-attachments/assets/cd75c1ed-432c-4878-98fb-cb982c5f206c" width="200"/>
 <img src="https://github.com/user-attachments/assets/cdcb691d-57f4-4eac-acf9-57b92575d0a7" width="200"/>
</p> 

<br/> <br/> 

## 사용 기술
> ### Architectur & Design Pattern
- Reactor
- Routor, Singleton

> ### Swift Framework
- UIKit

> ### OpenSource Libaries
- ReactorKit, RxSwift, Rxcocoa, RxGesture
- SocetIO
- Moya
- Kingfisher
- Realm
- SnapKit, Then
- KakaoOpenSDK

> ### Management
- Git, Github, Figma
<br/> <br/> 

## 주요 화면
> 워크스페이스 목록
   - 워크스페이스 생성 및 참여, 워크스페이스 목록 표시
> 홈
   - 내가 속한 채널 목록 표시
> 채팅
   - 실시간 채팅 전송
> 워크스페이스 생성
   
<br/> 

## 주요 기술

> ### 아키텍쳐 (Architecture)
<p align="center">
 <img src="https://github.com/user-attachments/assets/75721f18-66fe-4305-a9cc-68e9bb7c65e9"/>
</p> 

- View와 Business Logic을 분리하여 ViewController 간결화 <br/> 
- ReactorKit을 활용하여 View와 Reactor가 각각 Action 과 State를 전달하는 단방향 데이터 스트림 <br/> 
- View는 Reactor에 Action을 전달하고, Reactor는 View에 State를 전달하는 단방향 데이터 스트림 <br/> 
- Action, Mutation, State를 enum으로 규격화 하여 일관된 코드 작성 <br/> 
- Router Pattern을 활용한 Moya를 통해 API 요청을 구조화하고 , 반복되는 네트워크 작업을 추상화 <br/> 
- RxSwift Single Traits를 통한 에러 핸들링

<br/> 

> ### RxSwift와 Reactor 아키텍쳐 구현
- 아키텍처 및 구현 원칙
	- RxSwift의 상태 관리가 복잡해지는 문제를 해결하고, ViewModel에 상태 로직이 집중되는 문제를 해결하고자 **Reactor**를 도입
	- associatedType으로 Action, Mutation, State를 Reactor Protocol로 규격화하여 일괄된 코드를 작성
	- 데이터 흐름을 단방향으로 강제하고, View와 ViewModel(Reactor)의 역할을 명확하게 정의   

- Reactor 

	- mutate 메서드에서 Action을 인자로 받아 비즈니스 로직을 수행 후 Observable<Mutation> 객체를 반환
	- reduce 메서드에서 Mutation을 인자로 받아 기존 상태(state)에 변화를 적용하고, 새로운 State로 변환하여 View에 전달
	- Mutation을 사용하여 상태 변경을 세밀하게 제어하며 코드의 중복을 줄이고 유연성을 제공

- ViewController
	- UIView 객체들에서 방출되는 UI Component 이벤트들을 Action Stream에 매핑하여 Reactor에 전달
	- Reactor에서 방출된 State Stream을 구독하여 UI를 업데이트
	- Reactor는 외부에서 주입되며, bind(reactor:) 메서드에서 Action과 State의 바인딩 작업을 설정
	- ViewController는 Reactor와 역할을 명확히 분리하여, 비즈니스 로직을 갖지 않고 Action과 state의 매핑만 처리
	- ViewDidLoad 시점에 bind(reactor:) 메서드 실행
	- rootView의 대리자로서 화면전환 제어

- View:
	- UIView 객체들을 소유하고 화면을 구성
	- UI Component를 소유하고 화면을 그리며, UI 이벤트는 ViewController로 전달

<br/> 

> ### Moya를 활용한 Retour Pattern의 네트워크 관리

- 중앙 집중식 관리
	- URL, HTTP Method, Task, Header 등의 네트워크 요청 요소를 중앙에서 관리하여 코드의 일관성과 유지보수성을 극대화.
	- API 요청 요소를 명확히 분리하여 네트워크 레이어를 구조화
   
- 타입 안정성과 캡슐화된 요청
	- API 엔드포인트를 enum으로 정의해 컴파일 타임에 타입 안정성을 보장
	- 각 API 요청을 캡슐화하여 명확하고 직관적인 코드 작성 가능
	- 클라이언트는 엔드포인트 케이스를 호출하기만 하면 되므로 구현과 사용 간의 의존성을 낮춤
   
- BaseTarget의 활용
	- 모든 API 요청에 반복적으로 사용되는 baseURL, headers 를 BaseTarget으로 정의하여 중복 코드를 제거.
	- 재사용 가능한 공통 요소를 추상화하여 변경 사항에 유연하게 대처 가능
   
- Task로 요청 구성
	- Task를 사용하여 다양한 요청 유형(requestPlain, requestData, requestParameters, uploadMultipart 등)을 명확히 구분.
	- 파라미터 인코딩 방식을 명시적으로 지정하여 요청 데이터를 효율적으로 관리
   
- RxSwift를 통한 반응형 네트워크 처리
	- Moya와 RxSwift를 결합하여 네트워크 요청을 Single Traits로 래핑, 요청의 시작과 종료를 명확히 제어
	- 에러 처리 및 상태 변화를 반응형으로 처리하여 코드의 간결성과 가독성 향상
	- 성공과 실패를 구분하여 네트워크 에러에 대한 재시도, 대체 로직 적용 등 확장 가능성 에러 핸들링 로직 구현
   
- 확장 가능하고 테스트 가능한 설계
	- API 요청 케이스를 쉽게 추가하거나 수정할 수 있도록 구조화.
	- Moya의 stubbedResponses 기능을 활용해 네트워크 의존성을 제거하고 요청을 시뮬레이션하여 단위 테스트 가능

<br/> 

> ### SocketIO을 활용하여 양방향 통신을 통해 실시간 메시지 전달

- SocketIO 라이브러리를 활용한 소켓 연결
	- SocketIOManager는 SocketManager와 SocketIOClient를 활용하여 채널별 소켓 연결을 관리
 	- connect 메서드는 특정 채널에 대한 소켓 연결을 초기화하고, 연결 이벤트 리스너를 등록
  	- 앱의 Foreground / Background 상태 전환에 따라 소켓 연결을 자동으로 관리
  	  - Foreground 진입 시 소켓 재연결
  	  - Background 진입 또는 채팅방 종료 시 소켓 연결 해제.
  	    
- ReactorKit 상태 관리와 결합
	- 소켓 이벤트를 ChatReactor의 Mutation으로 변환하여 UI 상태를 업데이트
 		- 메시지 수신시, addChatmessage Mutation을 통해 UI에 새로운 메시지 반영
     
- 리소스 최적화
	- Background / Foreground 전환 시 NotificationCenter를 활용하여 소켓 연결 관리.
 	- disposeBag을 통한 리소스 정리 및 메모리 관리 (메모리 누수 방지)
  	- 필요하지 않은 경우 불필요한 소켓 연결을 해제하여 리소스 낭비 방지

<br/> <br/> <br/> 
## 트러블 슈팅
> ### 1. 앱 상태에 따른 소켓 연결 관리

- 문제 상황
	- 사용자가 채널 채팅방을 나갔을 때 (ViewWillDisappear) 소켓 연결을 해제하도록 구현했으나, 앱이 백그라운드로 전환 될 때는 소켓 연결이 유지되는 문제 발생
	- 이로 인해 불필요한 리소스 사용과 배터리 소모가 발생할 수 있는 상황

- 원인 분석
	-  앱의 상태변화 (Background / Foreground) 에 따른 소켓 연결 관리 로직이 누락
	-  소켓 연결 해제가 화면 전환 시에만 동작하고, 앱의 생명주기에 따른 처리가 되지 않음

- 해결 방안 및 구현
	- NotificationCenter를 활용하여 ChatReactor의 초기화 시점에 앱의 상태 변화를 감지하여 소켓 연결을 관리하도록 수정

``` Swift
init() {
    Observable.merge(
        NotificationCenter.default.rx.notification(UIApplication.didEnterBackgroundNotification).map { _ in false },
        NotificationCenter.default.rx.notification(UIApplication.didBecomeActiveNotification).map { _ in true }
    )
    .distinctUntilChanged()
    .subscribe(onNext: { [weak self] isActive in
        guard let self = self, let channelId = self.currentState.channelId else { return }
        if isActive {
            self.reconnectSocket(channelId: channelId)
        } else {
            self.disconnectSocket(channelId: channelId)
        }
    })
    .disposed(by: disposeBag)
}
```

- 결과 
	- 앱이 백그라운드로 전환 될때 자동으로 소켓 연결 해제
	- 앱이 다시 활성화 될 때 소켓 재연결
	- 화면 전환 시 (ViewWillDisappear)와 앱 상태 변화 시 모두 적절한 소켓 연결 관리 가능

- 교훈
	-  앱의 리소스 관리는 단순히 화면 전환뿐만 아니라 앱의 생명주기를 고려하여 설계해야 함을 느낌
	-  실시간 통신이 필요한 기능에서는 앱의 상태에 따른 연결 관리가 중요함을 깨달음

<br/> 

> ### 2. 로그인 성공 후 워크스페이스 화면 전환 문제

### 문제 개요
- 워크스페이스 리스트를 조회하고 해당 결과에 따라 화면을 전환하려고 했으나, 비동기 처리 중 workspaceList가 초기값인 빈 배열로 전달되어, 항상 HomeEmptyViewController로 화면이 전환되는 문제가 발생.
- 로그인 성공과 워크스페이스 조회 완료 상태가 비동기적으로 처리하는 과정에서 문제가 발생

### 문제 분석
1. 분제 발생 원인 :
	- 로그인 네트워크 통신 성공 후 isLoginSuccessful을 true로 변경하고, combineLatest로 워크스페이스 리스트를 가져오도록 했으나, 워크스페이스 데이터가 아직 로딩 중일 때 초기값으로 설정한 빈 배열이 반환되어 화면이 잘못 전환
		-  reactor.state.map { $0.setWorkspaceCheck } 의 초기값이 빈 배열로 설정되어 있었기 때문에, combineLatest로 상태를 결합하더라도 초기값이 반영되어 잘못된 화면 전환이 이루어짐.
	- 로그인 성공 여부와 워크스페이스 리스트 조회 완료 상태를 올바르게 연결하지 못한 것이 문제의 핵심


2. 기존 코드 흐름:
   - 로그인 성공 후 performLogin에서 setLoginSuccess(true)를 방출하고, performWorkspaceCheck에서 워크스페이스 정보를 가져옴
   - combineLatest로 isLoginSuccessful과 workspaceList를 결합하여, 두 상태 변화를 감지하려 했으나, 초기값으로 인한 비동기 데이터 흐름에서 오류 발생

### 해결 방법
- 워크스페이스 데이터 조회 완료 후 로그인 성공 상태를 설정하는 방식으로 변경 -> Reactor와 네트워크 요청의 동작 순서를 수정
- 즉, performLogin에서는 로그인 성공만 처리하고, performWorkspaceCheck에서 워크스페이스 조회가 완료되었을 때 로그인 성공 상태를 방출하도록 수정

- Reactor와 네트워크 요청의 동작 순서를 수정
	1. isLoginSuccessful을 로그인과 워크스페이스 조회가 모두 완료된 시점에 방출하도록 수정.
		- PerformLogin에서 .setLoginSuccess(true)를 방출하지 않고, 워크스페이스 조회 완료 후 방출되도록 변경
		- performWorkspaceCheck 내에서 .setWorkspaceCheck(workspaces)와 .setLoginSuccess(true)를 순차적으로 방출.
	2.	ViewController에서 isLoginSuccessful만 구독하여 로그인 성공 및 워크스페이스 조회 완료 상태에서만 화면 전환.
- 

### 수정된 코드
1. EmailLoginViewReactor 수정:
   - perfomLogin에서는 로그인 성공 후 performWorkspaceCheck만 호출하고, 그 이후에 워크스페이스 데이터를 받은 후 setLoginSuccess(true)를 방출하도록 변경

``` Swift
private func performLogin(email: String, password: String) -> Observable<Mutation> {
    let deviceToken = DeviceToken.deviceToken
    return UserNetworkManager.shared.login(query: LoginQuery(email: email, password: password, deviceToken: deviceToken))
        .asObservable()
        .flatMap { [weak self] response -> Observable<Mutation> in
            guard let self = self else { return Observable.empty() }
            if let token = response.token?.accessToken {
                UserDefaultsManager.shared.token = token
                return self.performWorkspaceCheck()  // 로그인 후 워크스페이스 조회만 진행
            } else {
                return Observable.just(.setError(NSError(domain: "LoginError", code: -1, userInfo: [NSLocalizedDescriptionKey: "로그인에 실패했습니다."])))
            }
        }
        .catch { error in
            return Observable.just(.setError(error))
        }
        .concat(Observable.just(.setLoading(false)))  // 로딩 상태 마무리
}
```
2. performWorkspaceCheck 수정:
   - performWorkspaceCheck에서 워크스페이스 리스트 조회가 완료되면 setLoginSuccess(true)를 방출하도록 하여, 두 상태가 동시에 완료된 후 화면 전환이 이루어지록 수정
``` Swift
private func performWorkspaceCheck() -> Observable<Mutation> {
    return WorkspaceNetworkManager.shared.workspacesListCheck()
        .asObservable()
        .flatMap { workspaces -> Observable<Mutation> in
            // 워크스페이스 조회가 완료되면 로그인 성공 상태를 true로 설정
            Observable.concat([
                Observable.just(.setWorkspaceCheck(workspaces)),
                Observable.just(.setLoginSuccess(true))  // 워크스페이스 조회 후 로그인 성공 상태 변경
            ])
        }
        .catch { error in
            return Observable.just(.setError(error))
        }
}
```

### 결과
- 로그인 후 워크스페이스 데이터 조회가 완료된 후에만 로그인 성공 상태가 변경되고, 그로 인해 화면전환이 로직이 정상적으로 작동
- 초기값으로 설정한 빈 배열 문제로 인한 잘못된 화면 전환 문제 해결

### 교훈 및 최종 결론
- 비동기 작업 간의 순서를 명확히 제어하여 상태 업데이트가 올바르게 반영되도록 설계
- 데이터가 완전히 로딩될 때까지 의존 상태가 변경되지 않도록 처리
- 초기값 상태 변화를 다룰 때, 상태 전환 시점을 명확히 지정해야 예상치 못한 동작을 방지할 수 있음.


### 추가 참고사항
- combineLatest를 사용해 여러 상태를 결합할 때, 초기값과 상태 변경 순서가 중요한 역할을 하므로, 초기값 설정과 상태의 변경 시점에 대해 주의 깊게 고려해야 함.





