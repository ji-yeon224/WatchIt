![[AppIcon.png | 150]]
## 🗓️ 프로젝트
- 개인프로젝트
- 24.04.12 ~ 24.05.23
## ✏️ 한 줄 소개
- 영화 또는 TV 시리즈를 검색하고 평가할 수 있는 애플리케이션

## 💻 기술 스택
- `SwiftUI`, `TCA`
- `Combine`, `async/await`
- `Realm`, `Alamofire`, `Kingfisher`, `AxisRatingBar`

## 📖 프로젝트 목표
- `SwiftUI`를 활용하여 프로젝트 구성
- `TCA` 아키텍쳐를 사용하여 단방향 흐름 구현
- 작품 검색 및 작품 별 별점 저장 구현

## 🚨 트러블 슈팅
### ✔️ Text 내의 라인 수 탐지
-  화면에 보여주려는 텍스트 데이터가 일정 라인 수 이하면 전문을 보여줘도 되지만 라인 수가 많아지게 되면 더보기 버튼을 삽입하려고 하였지만 데이터를 넣었을 경우 라인 수를 알아내기가 어려움
- iOS 16.0부터 사용할 수 있는 ViewThatFits를 활용하여 기준 라인 수를 넘어가 화면이 잘리게 되면 더보기 버튼을 삽입하도록 구현
```swift
// TruncatedTextView.swift
private func calculateTruncation() -> some View {
	ViewThatFits(in: .vertical) {
		Text(text)
			.font(Constants.FontStyle.caption.style)
			.hidden()
			.onAppear {
				guard isTruncated == nil else { return }
				isTruncated = false
			}
		Color.clear
			.hidden()
			.onAppear {
				guard isTruncated == nil else { return }
				isTruncated = true
			}
	}
}
```
[➡️ 트러블 슈팅 자세히 보기](https://iwntberich.tistory.com/97)

### ✔️ onAppear() 최초 호출 시 네트워크 통신 구현
- onAppear() 시점에 데이터를 가져오도록 구현하였는데, 탭 이동 후에도 여러번 호출되어 불필요한 네트워크 통신을 수행하게 되는 문제가 발생
- UIKit의 viewDidLoad()와 같은 기능 구현의 필요성을 느낌
- 상위 뷰에서 해당 화면의 onAppear() 호출 여부를 저장하고, @Binding을 통해 onAppear() 최초 호출 여부에 따라 네트워크 통신 수행
```swift 
struct MovieListView: View {

    @Binding var viewLoaded: Bool
    init(viewLoaded: Binding<Bool>) {
        self._viewLoaded = Binding(projectedValue: viewLoaded)
    }
    var body: some View {
        WithPerceptionTracking {
            ScrollView(.vertical) {
				...
            }
            .task {
                if !viewLoaded {
                    viewLoaded = true
                    store.send(.viewDidLoad) // 네트워크 통신 요청
                }
            }
        }
    }
}
```
## 🔎 주요 기능
### ✔️ 메인 트렌드 화면
- 상단의 탭을 통해 영화 트렌드와 TV 시리즈 트렌드를 나누어 볼 수 있다.

### ✔️  작품 상세 화면
- 선택한 작품의 포스터와 줄거리, 배우와 스탭 등에 대한 정보를 확인할 수 있다.
- 시청한 작품이라면 별점을 메길 수 있다.
- 아직 보지 않아서 찜해두고 싶은 작품이라면 상단 버튼으로 저장할 수 있다.

### ✔️ 검색 화면
- 원하는 작품을 키워드를 통해 검색하여 영화 또는 TV 시리즈를 필터링 하여 결과를 볼 수 있다.

### ✔️ 마이페이지
- 보고싶은 작품과 평가 작품 리스트를 볼 수 있다.
- 막대 차트를 통해 나의 평점 분포를 파악할 수 있다.
- 평가 작품 리스트는 평점 높은 순 또는 낮은 순으로 필터를 변경할 수 있다.


## ✍🏻 회고
- SwiftUI에 대한 학습을 위해 시작한 프로젝트라서 개발 속도가 느려지게 되었다. 레이아웃 구성에 감을 잡고 여러 기술들을 시도해보았기에 느렸지만 의미있는 프로젝트라고 생각이 든다.
- 처음 네트워크 통신을 구현할 때는 RxSwift처럼 Combine을 사용하였는데 이후에 async/await을 활용하는 방식으로 변경하였다. async/await을 사용하게 되니 비교적 코드가 간결해지게 되었다.
- 어느정도 SwiftUI가 익숙해지고 난 후 아키텍쳐를 적용해보고 싶다는 생각이 들었다. 가장 유명하다던 TCA를 적용하고자 구조에 대한 학습이 필요하여 적용하는데 시간이 좀 필요하였다. 예제 코드를 통해 학습 후 리팩토링을 하였더니 생각보다 시간이 적게 걸렸다. 이전에 적용해보았던 ReactorKit과 비슷하여 이해하는데 큰 어려움은 없었다.
