import ComposableArchitecture
import SwiftUI

@Reducer
struct DaysFeature {
    
    @ObservableState
    struct State {
        var days: IdentifiedArrayOf<DayFeature.State> = []
    }
    
    enum Action {
        case days(IdentifiedActionOf<DayFeature>)
        case addDayButtonTapped
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
                
            case .days:
                return .none
                
            case .addDayButtonTapped:
                state.days.append(
                    DayFeature.State(
                        id: UUID(),
                        date: Date()
                    )
                )
                return .none
                
            }
        }
        .forEach(\.days, action: \.days) {
            DayFeature()
        }
        ._printChanges()

    }
    
}


struct DaysView: View {
    
    var store: StoreOf<DaysFeature>
    
    var body: some View {
        VStack{
            Text( "Days: \(store.days.count)")
            Button {
                print(store.state)
            } label: {
                Text("print app state")
            }
            Button {
                store.send(.addDayButtonTapped)
            } label: {
                Text("add day")
            }
            
        }
        ScrollView{
            VStack {
                
                ForEach(
                    store.scope(state: \.days, action: \.days ),
                    id: \.state.id
                ) { dayStore in
                    DayView(store: dayStore)
                }
                
                Spacer(minLength: 30)
                
            }
        }
    }
}
