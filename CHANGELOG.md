# Change Log
## 0.10.0 - 2023-10-18
- Minimum Deployments iOS 11.0 변경
- XCFramework 적용

## 0.9.3 - 2023-07-21
- `INVShape` 겹침 상태에서 터치 이벤트 오류 수정

## 0.9.2 - 2023-06-09

## 0.9.1 - 2023-05-31
### Bug Fixes
- `INVShape` 재사용 시 비정상 종료되는 오류 수정

## 0.9.0 - 2023-05-19


## 0.8.1 - 2023-01-31
### Features
- 특정 화면 영역에 표출되는 POI의 정보를 반환하는 API 추가
    - `INVPoi`, `InaviMapView#pickPois`
- 지도 인증 과정에서 지도에 적용할 커스텀 지도 스타일을 설정하는 API 추가
    - `INVMapViewDelegate#willLoadInitialCustomMapStyleInCustomMapStyles`

## 0.8.0 - 2022-08-19
### Feature
- 하이브리드/항공 지도 유형 설정 API 추가
  - `INVMapType`, `InaviMapView#mapType`, `INVMapOptions#mapType`
- 좌표 변환 API 추가
  - `INVKatec`, `INVUtmk`, `INVTm`, `INVGrs80`


## 0.7.1 - 2022-03-30
### Feature
- 로고의 위치와 마진을 설정하는 API 추가
  - `InaviMapView#logoViewPosition`, `InaviMapView#logoViewMargins`, `INVMapOptions#logoViewPosition`, `INVMapOptions#logoViewMargins`

## 0.7.0 - 2021-05-10
### Feature
- `Map Studio` 서비스로 제작된 커스텀 지도 스타일을 지원하는 API 추가
  - `INVMapStyle`, `InaviMapSdk#getSavedCustomMapStyles`, `InaviMapView#customMapStyle`, `INVMapOptions#customMapStyle`, `INVMapSdkDelegate#authSuccess`
  
## 0.6.1 - 2021-02-22
### Improvements
- SDK 안정성 향상
## 0.6.0 - 2021-01-28
### Features
- 지도 심벌의 크기를 설정하는 API 추가
  - `InaviMapView#symbolScale`, `INVMapOptions#symbolScale`
- 지도의 기울기 각도 설정 시 건물 3D 효과 지원
## 0.5.3 - 2020-11-02

### Bug Fixes
- 백그라운드 진입 시 간헐적으로 비정상 종료되는 오류 수정

## 0.5.2 - 2020-09-22

### Features
- 지도 초기옵션 속성 추가
  - `INVMapOptions#minimumZoomLevel`, `INVMapOptions#maximumZoomLevel`, `INVMapOptions#minimumTilt`, `INVMapOptions#maximumTilt`, `INVMapOptions#zoomGesturesEnabled`, `INVMapOptions#scrollGesturesEnabled`, `INVMapOptions#rotateGesturesEnabled`, `INVMapOptions#tiltGesturesEnabled`, `INVMapOptions#logoClickEnabled`, `INVMapOptions#focalPointCenter`
- Interface Builder를 통한 지도 초기옵션 설정 지원

### Bug Fixes
- 마커의 아이콘 이미지가 간헐적으로 갱신되지 않는 오류 수정
- `INVClusterManager#invalidate` 호출 시 간헐적으로 기존 마커가 지도에 남아있는 오류 수정

## 0.5.1 - 2020-08-24

### Features
- 마커와 지도상 심볼 겹침을 설정하는 API 추가
  - `INVMarker#isAllowOverlapSymbols`

## 0.5.0 - 2020-07-28

### Features
- 경로 셰이프에 패턴 이미지 API 추가
  - `INVRoute#patternImage`, `INVRoute#patternScale`, `INVRoute#patternMargin`

## 0.4.6 - 2020-06-02

### Features
- 유효하지 않은 위치로 카메라 이동 요청 시 예외 발생하지 않도록 변경

### Bug Fixes
- 위치 아이콘의 위치 변경 시 간헐적으로 깜빡임 발생하는 오류 수정

### Improvements
- SDK 안정성 향상

## 0.4.5 - 2020-04-29

### Features
- 정보 창 표출 상태 변경 시 애니메이션 기본값 비활성화로 변경
- 정보 창 표출 상태 변경 시 애니메이션 설정 API 추가
  - `INVInfoWindow#isTransitionEnabled`
- 줌 또는 회전 제스처 시 기준점을 지도 중심으로 설정하는 API 추가
  - `InaviMapView#focalPointCenter`

## 0.4.4 - 2020-04-21

### Features
- 지도의 최소/최대 기울기 각도를 설정하는 API 추가
  - `InaviMapView#minimumTilt`, `InaviMapView#maximumTilt`

### Improvements
- SDK 안정성 향상

## 0.4.3 - 2020-03-30

### ETC
- Swift 5.2 대응

## 0.4.2 - 2020-03-10

### Features
- 특정 영역 전체가 보이는 카메라 위치 정보를 반환하는 API 추가
  - `InaviMapView#cameraFitBounds`

- 지도에 등록된 모든 셰이프를 지도에서 제거하는 API 추가
  - `InaviMapView#clearShapes`

## 0.4.1 - 2020-02-26

### Features
- 지도 로고 이미지 변경

## 0.4.0 - 2020-02-17

### Features
- 마커 클러스터링 기능 추가
  - `INVCluster`, `INVClusterItem`, `INVClusterManager`, `INVClusterManagerDelegate`, `INVClusterIconGenerator`, `INVDefaultClusterIconGenerator`
- `INVRoute#lineWidth` 속성 기본값 `5`로 변경
- `INVRoute#strokeWidth` 속성 기본값 `1` 로 변경
- `INVRouteLink#lineColor` 속성 기본값 `UIColor.whiteColor`로 변경
- `INVRouteLink#strokeColor` 속성 기본값 `UIColor.blackColor`로 변경
- `INVMarker#titleMaxWidth` 속성 기본값 `0`으로 변경

### Bug fixes
- `INVShape` 추가/제거 시 비정상 종료되는 오류 수정
- `INVRoute` 표출 시 간헐적으로 외곽선이 비정상적으로 표출되는 오류 수정

### ETC
- SDK Git LFS 적용

## 0.3.2 - 2020-01-16

### Features
- 마커 표출 상태 변경 시 애니메이션 기본값 비활성화로 변경
- 마커 표출 상태 변경 시 애니메이션 설정 API 추가
  - `INVMarker#isTransitionEnabled`
- `INVMarker#infoWindow` 속성 nullable로 변경

### Bug fixes
- 마커 타이틀에 "^" 문자 포함 시 줄바꿈되는 오류 수정
- Fly 애니메이션 타입 카메라 이동 시 자연스럽지 않은 오류 수정
- 줌 컨트롤러에 지도의 Padding 값이 적용되지 않는 오류 수정

## 0.3.1 - 2019-12-18

### Features
 - 지도 이동 영역 제한 API 추가
   - `InaviMapView#constraintBounds`
 - 로고 클릭 이벤트 활성화 여부 설정 API 추가
   - `InaviMapView#logoClickEnabled`
 - 오픈소스 라이선스, 법적 공지 ViewController 호출 API 추가
   - `INVMapSdk#presentLicenseViewController`, `INVMapSdk#presentLegalNoticeViewController`
 - 마커 아이콘과 타이틀 사이의 여백을 설정하는 기능 추가
   - `INVMarker#titleMargin`
 - `INVLatLng`, `INVLatLngBounds`의 property readonly 속성으로 변경
 - `INVCameraUpdateParams#scrollTo` *Deprecated* 적용 (`targetTo` 로 대체됩니다.)
 - `INVCameraUpdateParams#scrollBy` *Deprecated* 적용 (`targetBy` 로 대체됩니다.)
 - `INVLatLngBounds#latLngBoundsSouthWest` Deprecated 적용 (`boundsWithSouthWest` 로 대체됩니다.)

### Bug fixes
 - 지도 줌 제스처 비활성화 시 지도 더블 탭 이벤트 콜백이 호출되지 않는 오류 수정
 - 초기 지도 로딩 중 `UserTrackingMode`가 설정되지 않는 오류 수정
 - `INVRoute` 연결 부분이 매끄럽게 그려지지 않는 오류 수정
 - `INVCameraParams`에서 변화량으로 지도 이동 시 다른 속성이 무시되는 오류 수정

## 0.3.0 - 2019-11-26

### Features
 - `INVRoute` 추가 (지도 위에 경로를 표출하는 셰이프)
 - `INVMultiLine` *Deprecated* 적용 (`INVRoute`로 대체)

### Bug fixes
 - iOS 10 이하 단말에서 로고 클릭 시 비정상 종료되는 오류 수정

## 0.2.0 - 2019-11-14

### Features
 - `INVLocationIcon` 추가 (위치 아이콘의 모양과 위치를 변경할 수 있는 기능)

### Bug fixes
 - 특정 지도 레벨에서 셰이프가 사라지는 오류 수정
 - 간헐적으로 축척바의 거리가 비정상 표출하는 오류 수정
 
### Improvements
 - 빠르게 지도 레벨 변경 시 지도 아이콘이 겹치는 현상 개선

## 0.1.0 - 2019-10-29
- iOS SDK 초기 배포