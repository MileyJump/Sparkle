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



