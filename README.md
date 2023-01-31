# iNaviMaps SDK for iOS Demo
iOS 플랫폼에서 아이나비 지도를 사용하기 위한 프로젝트 기본 설정 방법을 설명합니다.

## 사전 준비
- 아이나비 지도를 사용하기 위해서는 인증을 위한 **앱키**가 필요합니다.

### 서비스 활성화 및 앱키 발급
- NHN Cloud 이용자
  - **앱키** 발급을 위해서는 **[NHN Cloud](https://www.toast.com/kr)** 계정이 필요합니다. 계정이 없다면 먼저 계정을 생성해주세요.
  - **[NHN Cloud Console](https://console.toast.com/)** 에서 서비스 선택 후 **Application Service > Maps**를 클릭합니다.
  - 지도 서비스를 사용할 **조직**과 **프로젝트**를 선택 후 [확인] 버튼을 클릭합니다.
  - 발급된 **앱키**는 **NHN Cloud Console** 상단 **URL & Appkey** 메뉴에서 확인할 수 있습니다.
- LG U+ 지도 인프라 이용자
  - 서비스명, 서비스 한 줄 소개, Bundle ID, 예상 사용량을 포함하여 [hongspan@inavi.kr](mailto:hongspan@inavi.kr)로 문의해 주세요.
  - 발급된 **앱키**는 보내주신 이메일로 회신 드리겠습니다.


## Project 환경 구성
아이나비 지도 SDK를 사용하기 위해서는 다음과 같은 순서로 프로젝트의 환경을 구성해주어야 합니다.

### Git LFS 설치
SDK 용량이 크기 때문에 Pod 의존성 설치 전 [Git Large File Storage(LFS)](https://git-lfs.github.com/) 설치가 필요합니다.
> `git-lfs가 설치되어 있지 않으면 SDK 의존성 설치가 정상적으로 진행되지 않아 빌드 시 오류가 발생합니다.`

```
brew install git-lfs
git lfs install
```

### Podfile 구성
다음과 같이 Podfile을 생성하여 아이나비 지도 SDK에 대한 Pod 의존성을 설정합니다.

```ruby
# Podfile
target 'iNaviMapsDemo' do
  use_frameworks!
  ...
  pod 'inavi-maps-sdk'
  ...
end
```

### SDK 설치
의존성 설정 후 Terminal에서 프로젝트 path로 이동한 다음, 아래 명령어를 실행하여 아이나비 지도 SDK를 설치합니다.
> `SDK 의존성 설치가 완료되었을 때 프레임워크 용량은 100MB 이상입니다.`
```
pod install --repo-update
```

### CocoaPods 캐시 삭제
간혹 이전에 다운로드 받은 SDK 의존성의 캐시가 남아있어 빌드에 오류가 발생할 수 있습니다.\
아래 명령어를 통해 아이나비 지도 SDK의 CocoaPods 캐시를 삭제할 수 있습니다.
```
pod cache clean inavi-maps-sdk
pod update inavi-maps-sdk
```


## 인증 유형 설정
> `LG U+ 지도 인프라 이용자만 해당됩니다.`

`info.plist` 파일에 다음과 같이 `Key-Value`를 추가합니다.
```xml
<!-- info.plist -->
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    ...
    <key>iNaviAuthType</key>
    <string>LgUplusMapInfra</string>
    ...
  </dict>
</plist>
```


## 앱키 설정
발급받은 앱키를 설정할 수 있도록 아래의 두 가지 방법을 제공합니다. 

> `앱키가 설정되지 않으면 지도 초기화 단계에서 인증 오류가 발생합니다.`

### 1. 프로젝트 info.plist에서 설정
`info.plist` 파일에 다음과 같이 `Key-Value`를 추가하여 앱키를 설정할 수 있습니다.
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

### 2. INVMapSdk API 호출로 설정
Application 생성 시점에 동적으로 [INVMapSdk](https://inavi-systems.github.io/inavi-maps-sdk-reference/ios/Classes/INVMapSdk.html) 싱글턴 객체의 함수를 호출하여 앱키를 설정할 수 있습니다.

```swift
// Swift
INVMapSdk.sharedInstance().appKey = "YOUR_APP_KEY"
```

## 주요 iNavi Maps SDK 안내
추가적인 iNavi Maps SDK 사용법은 [iNavi Maps API 센터](http://imapsapi.inavi.com/)를 참고하시기 바랍니다.
- [사업 제휴 문의](mailto:hongspan@inavi.kr)
- [기술 문의](mailto:abskl@inavi.kr)


## License
© 2019-2023. iNavi Systems Corp. All rights reserved.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
