# iNaviMaps SDK for iOS Demo
iOS 플랫폼에서 아이나비 지도를 사용하기 위한 프로젝트 기본 설정 방법을 설명합니다.

### 사전 준비
- 아이나비 지도를 사용하기 위해서는 인증을 위한 **Appkey**가 필요합니다.

#### 서비스 활성화
- **[NHN Toast Console]** 에서 서비스 선택 후 Application Service > Maps를 클릭합니다

#### Appkey 확인
- **Appkey**는 **TOAST Console** 상단 **URL & Appkey** 메뉴에서 확인할 수 있습니다.


### Project 환경 구성
SDK 용량이 크기 때문에 Pod 의존성 설치 전 [Git Large File Storage(LFS)](https://git-lfs.github.com/) 설치가 필요합니다.
> `git-lfs가 설치되어 있지 않으면 SDK 의존성 설치가 정상적으로 진행되지 않습니다.`

```
brew install git-lfs
git lfs install
```


다음과 같이 Podfile을 생성하여 아이나비 지도 SDK에 대한 Pod 의존성을 설정합니다.

> `아이나비 지도 iOS SDK는 CocoaPods를 통해 배포되며, Beta 기간 종료 후에는 정책에 맞춰 변경될 수 있습니다. (사전 공지 예정)`

```ruby
# Podfile
target 'iNaviMapsDemoiOS' do
  use_frameworks!
  ...
  pod 'inavi-maps-sdk'
  ...
end
```

의존성 설정 후 Terminal에서 프로젝트 path로 이동한 다음, 아래 명령어를 실행하여 아이나비 지도 SDK를 설치합니다.
> `SDK 의존성 설치가 완료되었을 때 프레임워크 용량은 약 150MB 입니다.`
```
pod install --repo-update
```

### Appkey 설정
발급받은 Appkey를 설정할 수 있도록 아래의 두 가지 방법을 제공합니다. 

> `Appkey가 설정되지 않으면 지도 초기화 단계에서 인증 오류가 발생합니다.`

#### 1. 프로젝트 info.plist에서 설정
`info.plist`파일 내부에 Appkey를 설정할 수 있습니다.
```xml
<!-- info.plist -->
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	...
	<key>iNaviAppKey</key>
	<string>YOUR_APP_KEY</string>
	...
</dict>
</plist>
```

#### 2. INVMapSdk API 호출로 설정
Application 생성 시점에 동적으로 [INVMapSdk] 싱글턴 객체의 함수를 호출하여 Appkey를 설정할 수 있습니다.

```swift
// Swift
INVMapSdk.sharedInstance().appKey = "YOUR_APP_KEY"
```

## 주요 iNavi Maps SDK 안내
추가적인 iNavi Maps SDK 사용법은 [iNavi Maps API 센터](http://imapsapi.inavi.com/)를 참고하시기 바랍니다.

[INVMapSdk]: <https://inavi-systems.github.io/inavi-maps-sdk-reference/ios/Classes/INVMapSdk.html>
[NHN Toast Console]: <https://console.toast.com/>

## License
Copyright © 2019-2020 iNavi Systems

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
