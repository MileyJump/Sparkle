# 🎇 Sparkle (스파클)

 다양한 사람들과 커뮤니케이션 혹은 협업을 위한 소통 플랫폼 <br/> <br/> <br/> 
*"**Sparkle**은 메세지를 주고 받으며 소통하고, 그 과정에서 새로운 아이디어가 반짝이는 순간을 만들어가길 바라는 마음을 담았습니다."*

## 프로젝트 소개




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
iOS: UIKit, ReactorKit, RxSwift, RxCocoa <br/> 
Architectur: Reactor <br/> 
NetWork: Moya <br/> 
Local DataBase: Realm <br/>
Design Pattern: Singlngton <br/> 
Management: Git, Github, Figma
<br/> <br/> 

## 아키텍쳐 (Architecture)
<p align="center">
 <img src="https://github.com/user-attachments/assets/75721f18-66fe-4305-a9cc-68e9bb7c65e9"/>
</p> 
* View와 Business Logic을 분리하여 ViewController 간결화 <br/> 
* ReactorKit을 활용하여 View와 Reactor가 각각 Action 과 State를 전달하는 단방향 데이터 스트림 <br/> 
* View는 Reactor에 Action을 전달하고, Reactor는 View에 State를 전달하는 단방향 데이터 스트림 <br/> 
* Action, Mutation, State를 enum으로 규격화 하여 일관된 코드 작성 <br/> 
* Router Pattern을 활용한 Moya를 통해 API 요청을 구조화하고 , 반복되는 네트워크 작업을 추상화 <br/> 
* RxSwift Single Traits를 통한 에러 핸들링

### 주요 화면
1. 워크스페이스 목록 : 워크스페이스 생성 및 참여, 워크스페이스 목록 표시
2. 홈 : 내가 속한 채널 목록 표시
3. 채팅 : 실시간 채팅 전송
4. 워크스페이스 생성

### 프로젝트 주요 기술


#### RxSwift와 Reactor 아키텍쳐 구현
- 설계
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



#### Moya를 활용한 Retour Pattern의 네트워크 관리

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

#### SocketIO을 활용하여 양방향 통신을 통해 실시간 메시지 전달
- SocketIO 라이브러리를 사용하여 서버와 클라이언트 연결
- NotificationCenter를 통해 Background, Foreground 시점의 소켓 해제 및 연결 처리 구현


## 트러블 슈팅
### 1. 로그인 성공 후 워크스페이스 화면 전환 문제

- 문제 상황
	- EmailLoginViewReactor에서 로그인 버튼 탭 시, performLogin이 호출되고 로그인 성공 후 performWorkspaceCheck를 통해 워크스페이스 데이터를 요청하도록 구현함.
	1. isLoginSuccessful 상태가 ture로 변경된 순간에 ViewController에서 workspaceList를 확인해 화면 전환.
	2. performWorkspaceCheck가 완료되기 전에 workspaceList의 초기값(빈 배열)이 사용되어 HomeEmtyViewController로 잘못된 화면 전환 발생

- 원인 분석
	- reactor.state.map { $0.setWorkspaceCheck } 의 초기값이 빈 배열로 설정되어 있었기 때문에, combineLatest로 상태를 결합하더라도 초기값이 반영되어 잘못된 화면 전환이 이루어짐.
	- 로그인 성공 여부와 워크스페이스 리스트 조회 완료 상태를 올바르게 연결하지 못한 것이 문제의 핵심


- 해결 방안 및 구현
	- 로그인 성공 여부와 워크스페이스 리스트의 조회 완료를 보다 명확히 연결하도록 Reactor와 네트워크 요청의 동작 순서를 수정.
	1. 	isLoginSuccessful을 로그인과 워크스페이스 조회가 모두 완료된 시점에 방출하도록 수정.
		- performLogin에서 바로 .setLoginSuccess(true)를 방출하지 않고, 워크스페이스 조회 완료 후 방출하도록 변경.
		-	performWorkspaceCheck 내에서 .setWorkspaceCheck(workspaces)와 .setLoginSuccess(true)를 순차적으로 방출.
	2.	ViewController에서 isLoginSuccessful만 구독하여 로그인 성공 및 워크스페이스 조회 완료 상태에서만 화면 전환.

``` Swift
private func performLogin(email: String, password: String) -> Observable<Mutation> {
    let deviceToken = DeviceToken.deviceToken
    return UserNetworkManager.shared.login(query: LoginQuery(email: email, password: password, deviceToken: deviceToken))
        .asObservable()
        .flatMap { [weak self] response -> Observable<Mutation> in
            guard let self = self else { return Observable.empty() }
            if let token = response.token?.accessToken {
                UserDefaultsManager.shared.token = token
                return self.performWorkspaceCheck()
            } else {
                return Observable.just(.setError(NSError(domain: "LoginError", code: -1, userInfo: [NSLocalizedDescriptionKey: "로그인에 실패했습니다."])))
            }
        }
        .catch { error in
            return Observable.just(.setError(error))
        }
        .concat(Observable.just(.setLoading(false)))
}

private func performWorkspaceCheck() -> Observable<Mutation> {
    return WorkspaceNetworkManager.shared.workspacesListCheck()
        .asObservable()
        .flatMap { workspaces -> Observable<Mutation> in
            // 워크스페이스 체크 후 상태 업데이트
            Observable.concat([
                Observable.just(.setWorkspaceCheck(workspaces)),
                Observable.just(.setLoginSuccess(true)) // 워크스페이스 조회 완료 후 성공 상태 방출
            ])
        }
        .catch { error in
            return Observable.just(.setError(error))
        }
}
```
- 결과
  - performWorkspaceCheck에서 워크스페이스 데이터를 정상적으로 조회한 후, setLoginSuccess(true)를 방출하여 화면 전환 로직이 정상적으로 작동.
  -	초기값 문제로 인해 발생했던 빈 배열로 인한 잘못된 화면 전환 문제 해결.

- 교훈
  - 비동기 작업 간의 순서를 명확히 제어하여 상태 업데이트가 올바르게 반영되도록 설계.
  -	초기값과 상태 변화를 다룰 때, 상태 전환 시점을 명확히 지정해야 예상치 못한 동작을 방지할 수 있음.







