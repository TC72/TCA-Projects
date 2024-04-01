import ComposableArchitecture
import SwiftUI

@main
struct BasicApp: App {
    let daysStore = Store(initialState: DaysFeature.State()) {
        DaysFeature()
    }
    
    
    var body: some Scene {
        WindowGroup {
            DaysView(store: daysStore)
        }
    }
}
