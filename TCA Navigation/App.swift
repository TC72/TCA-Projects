import ComposableArchitecture
import SwiftUI

@main
struct NavigationApp: App {
    let daysStore = Store(initialState: DaysFeature.State()) {
        DaysFeature()
        ._printChanges()
    }
    
    
    var body: some Scene {
        WindowGroup {
            DaysView(store: daysStore)
        }
    }
}
