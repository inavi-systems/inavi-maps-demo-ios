import SwiftUI
import iNaviMaps

private final class MapTypeStore {
    var mapRef: InaviMapView?
}

struct MapTypeView: View {
    @State private var store = MapTypeStore()
    @State private var selectedTitle = "일반 지도"

    private let items: [(title: String, type: INVMapType)] = [
        ("일반 지도", .normal),
        ("항공 지도", .satellite),
        ("하이브리드 지도", .hybrid),
        ("일반 지도(지형도)", .normalWithHillshade),
        ("항공 지도(지형도)", .satelliteWithHillshade),
        ("하이브리드 지도(지형도)", .hybridWithHillshade),
    ]

    var body: some View {
        ZStack {
            InaviMapViewRepresentable(onMapViewReady: { store.mapRef = $0 })
                .edgesIgnoringSafeArea(.bottom)
            DemoOverlayPanel(alignment: .bottom) {
                Menu {
                    ForEach(items.reversed(), id: \.title) { item in
                        Button(item.title) {
                            selectedTitle = item.title
                            store.mapRef?.mapType = item.type
                        }
                    }
                } label: {
                    HStack {
                        Text(selectedTitle)
                        Spacer()
                        Image(systemName: "chevron.down")
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(6)
                    .foregroundColor(.primary)
                }
            }
        }
        .navigationTitle("Map Type")
        .navigationBarTitleDisplayMode(.inline)
    }
}
