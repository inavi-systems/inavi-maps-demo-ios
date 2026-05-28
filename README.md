# iNaviMaps SDK for iOS Demo
iOS 플랫폼에서 아이나비 지도를 사용하기 위한 프로젝트 기본 설정 방법을 설명합니다.
- `0.20.0 미만 버전은 일정 시간이 지난 후 지원이 종료될 수 있습니다. 0.20.0 이상 버전으로 업그레이드를 권장합니다.`
- 0.20.0 미만 버전의 설명은 [이전 README.md](./README_DEPRECATED.md)를 참조하시기 바랍니다.

## 사전 준비
- 아이나비 지도를 사용하기 위해서는 인증을 위한 **APP KEY**가 필요합니다.

### 서비스 활성화 및 APP KEY 발급
- **APP KEY** 발급을 위해서는 **[iMPS](https://mapsapi.inavisys.com/)** 계정이 필요합니다. 계정이 없다면 먼저 계정을 생성해주세요.
- **[iMPS Console](https://mapsapi.inavisys.com/dash-board/)** 에서 APP을 생성합니다.
- 생성된 APP에서 상품을 신청하시면, **APP KEY**를 확인할 수 있습니다.

## SDK 설치
아이나비 지도 SDK는 **Swift Package Manager(SPM)** 또는 **CocoaPods** 두 가지 방식으로 설치할 수 있습니다. 

### Swift Package Manager (권장)
Xcode 메뉴에서 `File > Add Package Dependencies...`를 선택한 후 아래 URL을 입력하여 패키지를 추가합니다.

```
https://github.com/inavi-systems/inavi-maps-sdk-ios
```

`Package.swift`를 직접 사용하는 경우 다음과 같이 의존성을 추가합니다.

```swift
// Package.swift
dependencies: [
    .package(url: "https://github.com/inavi-systems/inavi-maps-sdk-ios", from: "0.22.0")
],
targets: [
    .target(
        name: "YourTarget",
        dependencies: [
            .product(name: "iNaviMaps", package: "inavi-maps-sdk-ios")
        ]
    )
]
```

### CocoaPods
`Podfile`에 아이나비 지도 SDK 의존성을 추가합니다.

```ruby
# Podfile
target 'iNaviMapsDemo' do
  use_frameworks!
  ...
  pod 'inavi-maps-sdk'
  ...
end
```

의존성 설정 후 프로젝트 경로에서 아래 명령어로 SDK를 설치합니다.

> SDK 의존성 설치가 완료되었을 때 프레임워크 예상 용량은 아래와 같습니다.
> - `버전 0.10.0 이상` - 20MB 이상
> - `버전 0.10.0 미만` - 100MB 이상

```bash
pod install --repo-update
```

이전에 다운로드된 캐시로 인해 빌드 오류가 발생할 경우 아래 명령어로 캐시를 초기화합니다.

```bash
pod cache clean inavi-maps-sdk
pod update inavi-maps-sdk
```

> ⚠️ **버전 0.10.0 미만 사용 시 Git LFS 필요**
>
> SDK 용량이 크기 때문에 Pod 의존성 설치 전 [Git Large File Storage(LFS)](https://git-lfs.github.com/) 설치가 필요합니다. 미설치 시 SDK 의존성 설치가 정상적으로 진행되지 않아 빌드 오류가 발생합니다.
>
> ```bash
> brew install git-lfs
> git lfs install
> ```

## APP KEY 설정
발급받은 APP KEY는 다음 두 가지 방법 중 하나로 설정할 수 있습니다.

> `앱키가 설정되지 않으면 지도 초기화 단계에서 인증 오류가 발생합니다.`

### 1. `Info.plist`에 설정
`Info.plist` 파일에 다음과 같이 `Key-Value`를 추가하여 앱키를 설정할 수 있습니다.

```xml
<!-- Info.plist -->
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

### 2. `INVMapSdk` API 호출로 설정
Application 생성 시점에 동적으로 [INVMapSdk](https://inavi-systems.github.io/inavi-maps-sdk-reference/ios/Classes/INVMapSdk.html) 싱글턴 객체의 함수를 호출하여 앱키를 설정할 수 있습니다.

```swift
// Swift
INVMapSdk.sharedInstance().appKey = "YOUR_APP_KEY"
```

## 주요 iNavi Maps SDK 안내
추가적인 iNavi Maps SDK 사용법은 [iMPS](https://mapsapi.inavisys.com/)를 참고하시기 바랍니다.
- [사업 제휴 문의](mailto:hongspan@inavi.kr)
- [기술 문의](mailto:abskl@inavi.kr)


## License
© 2019-2026. iNavi Systems Corp. All rights reserved.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
