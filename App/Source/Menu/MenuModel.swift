import SwiftUI

struct MenuItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let destination: () -> AnyView
}

struct MenuSection: Identifiable {
    let id = UUID()
    let header: String
    let items: [MenuItem]
}

enum AppMenu {
    static let sections: [MenuSection] = [
        MenuSection(header: "지도", items: [
            MenuItem(title: "InaviMapView",
                     subtitle: "InaviMapView를 사용하여 지도 표출",
                     destination: { AnyView(MapDemoView()) }),
        ]),
        MenuSection(header: "셰이프", items: [
            MenuItem(title: "INVMarker", subtitle: "마커",
                     destination: { AnyView(INVMarkerView()) }),
            MenuItem(title: "INVMarker Overlap", subtitle: "마커 겹침 발생 시 정책 설정",
                     destination: { AnyView(INVMarkerOverlapView()) }),
            MenuItem(title: "INVInfoWindow", subtitle: "정보 창",
                     destination: { AnyView(INVInfoWindowView()) }),
            MenuItem(title: "INVPolygon", subtitle: "다각형 그리기",
                     destination: { AnyView(INVPolygonView()) }),
            MenuItem(title: "INVPolyline", subtitle: "선형 그리기",
                     destination: { AnyView(INVPolylineView()) }),
            MenuItem(title: "INVRoute", subtitle: "경로 그리기",
                     destination: { AnyView(INVRouteView()) }),
            MenuItem(title: "INVCircle", subtitle: "원 그리기",
                     destination: { AnyView(INVCircleView()) }),
            MenuItem(title: "Global Z-Index", subtitle: "셰이프 표출 우선순위 설정",
                     destination: { AnyView(GlobalZIndexView()) }),
        ]),
        MenuSection(header: "클러스터링", items: [
            MenuItem(title: "Marker Clustering", subtitle: "마커 클러스터링",
                     destination: { AnyView(MarkerClusteringView()) }),
        ]),
        MenuSection(header: "카메라", items: [
            MenuItem(title: "Camera Move", subtitle: "카메라 이동",
                     destination: { AnyView(CameraMoveView()) }),
            MenuItem(title: "INVCameraUpdateParams", subtitle: "INVCameraUpdateParams를 이용한 카메라 이동",
                     destination: { AnyView(INVCameraUpdateParamsView()) }),
            MenuItem(title: "Camera Move to Fit Bounds", subtitle: "영역이 보이는 위치로 카메라 이동",
                     destination: { AnyView(CameraFitBoundsView()) }),
            MenuItem(title: "Camera Events", subtitle: "카메라 이벤트",
                     destination: { AnyView(CameraEventView()) }),
        ]),
        MenuSection(header: "지도 옵션", items: [
            MenuItem(title: "Map Type", subtitle: "지도 타입",
                     destination: { AnyView(MapTypeView()) }),
            MenuItem(title: "Map Custom Style", subtitle: "지도 커스텀 스타일",
                     destination: { AnyView(MapCustomStyleView()) }),
            MenuItem(title: "Map Padding", subtitle: "지도 패딩 설정",
                     destination: { AnyView(MapPaddingView()) }),
            MenuItem(title: "Map Gesture", subtitle: "지도 제스처 설정",
                     destination: { AnyView(MapGestureView()) }),
            MenuItem(title: "Map Controller", subtitle: "지도 컨트롤러 설정",
                     destination: { AnyView(MapControllerView()) }),
            MenuItem(title: "Map Restriction", subtitle: "지도 제한",
                     destination: { AnyView(MapRestrictionView()) }),
            MenuItem(title: "Map Symbol Scale", subtitle: "지도 심벌 크기",
                     destination: { AnyView(MapSymbolScaleView()) }),
            MenuItem(title: "Map Language", subtitle: "지도 라벨 언어 변경",
                     destination: { AnyView(MapLanguageView()) }),
        ]),
        MenuSection(header: "클릭 이벤트", items: [
            MenuItem(title: "Map Click", subtitle: "지도의 클릭, 롱 클릭, 더블 클릭 이벤트 처리",
                     destination: { AnyView(MapClickEventView()) }),
            MenuItem(title: "Shape Click", subtitle: "셰이프의 클릭 이벤트 처리",
                     destination: { AnyView(ShapeClickEventView()) }),
        ]),
        MenuSection(header: "위치", items: [
            MenuItem(title: "User Tracking Mode", subtitle: "위치 추적 모드 사용",
                     destination: { AnyView(UserTrackingModeView()) }),
            MenuItem(title: "Location Icon", subtitle: "위치 아이콘 설정",
                     destination: { AnyView(LocationIconView()) }),
        ]),
        MenuSection(header: "기타", items: [
            MenuItem(title: "IndoorMap", subtitle: "실내 지도를 표출한다.",
                     destination: { AnyView(IndoorMapView()) }),
            MenuItem(title: "Projection", subtitle: "화면상 위치를 지도 좌표로 변환",
                     destination: { AnyView(ProjectionView()) }),
            MenuItem(title: "Coordinates Conversion", subtitle: "좌표계 변환",
                     destination: { AnyView(CoordinatesConversionView()) }),
            MenuItem(title: "Pick POIs", subtitle: "특정 화면 영역에 표출되는 POI의 정보를 확인한다.",
                     destination: { AnyView(PickPoisView()) }),
        ]),
    ]
}
