import SwiftUI
import UIKit

@main
struct INaviMapsApp: App {
    init() {
        configureNavigationBarAppearance()
    }

    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }

    private func configureNavigationBarAppearance() {
        let red = UIColor(red: 0.92, green: 0.16, blue: 0.19, alpha: 1.0)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = red
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().overrideUserInterfaceStyle = .dark
    }
}
