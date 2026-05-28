import SwiftUI
import iNaviMaps

private final class IndoorMapStore {
    var mapRef: InaviMapView?
    var currentPlaceId: NSNumber?
    var currentFloor: INVFloor?
}

struct IndoorMapView: View {
    @State private var store = IndoorMapStore()
    @State private var indoorEnabled = true
    @State private var floors: [INVFloor] = []
    @State private var selectedFloorIdx: Int = 0

    var body: some View {
        ZStack {
            InaviMapViewRepresentable(
                onMapViewReady: { mapView in
                    store.mapRef = mapView
                    mapView.moveCamera(INVCameraUpdate(targetTo: INVLatLng(lat: 37.49380, lng: 127.11573), zoomTo: 16.0))
                },
                onIndoorChange: { placeId, newFloors, floor in
                    applyIndoorUpdate(placeId: placeId, floors: newFloors ?? [], floor: floor)
                }
            )
            .edgesIgnoringSafeArea(.bottom)

            if !floors.isEmpty {
                VStack {
                    Picker("층 선택", selection: $selectedFloorIdx) {
                        ForEach(0..<floors.count, id: \.self) { idx in
                            Text(floors[idx].name ?? "").tag(idx)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(width: 100)
                    .background(Color(.systemBackground).opacity(0.8))
                    .cornerRadius(12)
                    .onChange(of: selectedFloorIdx) { idx in
                        guard floors.indices.contains(idx) else { return }
                        let floor = floors[idx]
                        store.currentFloor = floor
                        store.mapRef?.setIndoorFloor(floor)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
            }

            DemoOverlayPanel(alignment: .bottom) {
                Toggle("실내 지도 사용", isOn: $indoorEnabled)
                    .onChange(of: indoorEnabled) { v in store.mapRef?.isIndoorMapEnabled = v }
            }
        }
        .navigationTitle("IndoorMap")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func applyIndoorUpdate(placeId: NSNumber?, floors newFloors: [INVFloor], floor: INVFloor?) {
        let hasPlaceChanged = store.currentPlaceId != placeId
        if hasPlaceChanged {
            store.currentPlaceId = placeId
            store.currentFloor = floor
            floors = newFloors
            if let cur = floor, let idx = newFloors.firstIndex(where: { $0.floorId == cur.floorId }) {
                selectedFloorIdx = idx
            }
        } else {
            store.currentFloor = floor
            if let cur = floor, let idx = floors.firstIndex(where: { $0.floorId == cur.floorId }) {
                selectedFloorIdx = idx
            }
        }
    }
}
