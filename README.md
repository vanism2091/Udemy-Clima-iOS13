
![App Brewery Banner](Documentation/AppBreweryBanner.png)

#  Clima

- [Clima](#clima)
  - [Our Goal](#our-goal)
  - [What you will create](#what-you-will-create)
  - [What you will learn](#what-you-will-learn)
    - [Condition Codes](#condition-codes)
  - [143: Dark Mode and Working with Vector Assets](#143-dark-mode-and-working-with-vector-assets)
    - [SF Symbols](#sf-symbols)
    - [dark mode](#dark-mode)
  - [144: Learn to use the UITextField](#144-learn-to-use-the-uitextfield)
    - [UITextFieldDeligate](#uitextfielddeligate)

## Our Goal

It’s time to take our app development skills to the next level. We’re going to introduce you to the wonderful world of Application Programming Interfaces (APIs) to grab live data from the internet. If you’re dreaming of making that Twitter-powered stock trading app then you’re about add some serious tools to your toolbelt!


## What you will create

By the end of the module, you will have made a beautiful, dark-mode enabled weather app. You'll be able to check the weather for the current location based on the GPS data from the iPhone as well as by searching for a city manually. 

## What you will learn

* How to create a dark-mode enabled app.
* How to use vector images as image assets.
* Learn to use the UITextField to get user input. 
* Learn about the delegate pattern.
* Swift protocols and extensions. 
* Swift guard keyword. 
* Swift computed properties.
* Swift closures and completion handlers.
* Learn to use URLSession to network and make HTTP requests.
* Parse JSON with the native Encodable and Decodable protocols. 
* Learn to use Grand Central Dispatch to fetch the main thread.
* Learn to use Core Location to get the current location from the phone GPS. 

### Condition Codes
```
switch conditionID {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
```

>This is a companion project to The App Brewery's Complete App Development Bootcamp, check out the full course at [www.appbrewery.co](https://www.appbrewery.co/)

![End Banner](Documentation/readme-end-banner.png)


## 143: Dark Mode and Working with Vector Assets
### SF Symbols
[SF Symbols](https://developer.apple.com/design/human-interface-guidelines/foundations/sf-symbols) provides thousands of consistent, highly configurable symbols that integrate seamlessly with the San Francisco system font, automatically aligning with text in all weights and sizes.

### dark mode 
[Apple Doc](https://developer.apple.com/documentation/uikit/appearance_customization/supporting_dark_mode_in_your_interface)
Main.storyboard > 하단 중앙의 Dark mode 아이콘을 클릭하면 인터페이스가 바뀜
- How?
Color(Tint) 중 custom 말고 System, Label 등등이 붙은 거 선택하면 됨 
- Custom Color도 Mode에 가변적으로 하고싶으면?
  - Assets.xcassets > + > Color Set > Appearances: Any, Light, Dark

- mode에 따라 바뀌는 Background Image
  - png 대신 pdf, vector 이미지 사용할 수 있다.
    - vector 이미지는 깍두기가 생기지 않음(they don't pixelate)
    - [ ] Resizing -> [x] Preserve Vector Data
    - [ ] Scales -> Single Scale


## 144: Learn to use the UITextField
- Learn to use the UITextField to get user input.
- interface builder - Text
- default로 interface 변화에 따른 색 변화 적용되어 있음
- Attr Inspecter > Text Input traits
  - Content Type: Unspecified
    - 내용 어떤 컨텍스트일지 모름
  - Capitalization: Words
    - 단어마다 첫 글자 대문자로
  - Return Key: Go
    - return key 누르면 할 액션: go
  - [ ] Secure Text Entry : 
    - pw field처럼 입력 값을 *로 표시

- Placeholder
### UITextFieldDeligate
- 사용하려면
  - 아래와 같이 UITextFieldDeligate 프로토콜을 추가로 상속한다. 왜? 텍스트 필드 인풋 수정/검증을 더 편하게 관리할 수 있음
    ```swift
    import UIKit

    class WeatherViewController: UIViewController, UITextFieldDelegate {
        ...
        override func viewDidLoad() {
            ....        
            searchTextField.delegate = self
        }        
    }
    ```
  - `searchTextField.deligate = self`
    - text field가 self(=WeatherViewController)에게 report back 할거임(알아야 할 사항 알려줄거임)
      - 유저가 typing 시작했어! 그만뒀어! 텍스트 필드 말고 다른데 선택했어! 
  - 위 2개를 하게 되면, textFieldShouldReturn(야 뷰컨아, 유저가 리턴키를 눌렀어. 뭐할래?) 과 같은 method를 사용할 수 있음
    - textFieldShouldReturn
      - 진짜 리턴할거임? return True
      - validation check 통과 실패 False

- 키보드 사라지게 하기
  - 키보드는 dismiss 하지 않는 이상 사라지지 않음
  - searchTextField.endEditing(true)

- 엔터 / 찾기 누른 후 텍스트 필드 비우기
  - 나는 그냥 `searchTextField.setValue("", forKey: "text")` 이걸 추가할 줄 알았는데
  - deligate가 또 나왔어요
    ```swift
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchTextField.setValue("", forKey: "text")
    }
    ```
  - 해당 뷰의 어떤 텍스트 필드든 종료되면 이 함수가 호출된다.

- textFieldShouldEndEditing
  - Should: asking for permission. 뭐할까?
  - 이 함수로 user input validation 하기 좋음

  - 이전 함수는 searchTextField < 특정한 UITextField 를 집었지만, 이번 함수에선 일반적인 param으로 받아온 textField 를 활용. 왜? 보편적인 기능이므로.
  - textField는 어디에서 오는가? 메소드를 trigger하는 textField가 들어간다.
  - 

# Internal and External Parameter Names
```swift
// Defining the Function
func myFunc(name inter: Type) {
    print(inter)
}
            
// Calling the Function
myFunc(name: value)
            
// Defining the Function
func myFunc2(_ inter: Type) {
    print(inter)
}
            
myFunc2(value)
```
            
# 155. Method Naming Conventions and Error Handling
    
# 156. Updating the UI by Using the DispatchQueue
UILabel.text must be used from main thread only
그냥 함수 안에서 바로 label을 변경하면 앱 크래시
https://developer.apple.com/documentation/xcode/diagnosing-memory-thread-and-crash-issues-early
networking, 컴플리션 핸들러 등 같은 일들은 Background queue에서 일어남. 그래서 ui 이용하는 데 막힘 없게끔 하는거. 그런데 ui업데이트는 메인스레드에서 일어나야함. 그래야 끊김 없이 반응형 앱을 만들 수 있으니깐. 그래서 UI 업뎃 코드는 메인 큐에 넣어줘야함.
```swift
DispatchQueue.main.async {
    // code...
}
```
