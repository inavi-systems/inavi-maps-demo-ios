import iNaviMaps

extension INVLatLng {
    var formattedString: String {
        return String(format: "(%.5f, %.5f)", lat, lng)
    }
}
