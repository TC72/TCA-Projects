import ComposableArchitecture
import SwiftUI

@main
struct BasicApp: App {
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
