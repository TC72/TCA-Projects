import ComposableArchitecture
import SwiftUI

@Reducer
struct DaysFeature {

    @ObservableState
    struct State {
        var path = StackState<Path.State>()
        var days: IdentifiedArrayOf<DayFeature.State> = []
    }

    enum Action {
        case path(StackAction<Path.State, Path.Action>)
        case days(IdentifiedActionOf<DayFeature>)
        case addDayButtonTapped
    }

    @Reducer
    enum Path {
        case editDay(DayFeature)
        case editNote(NoteFeature)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
                
            case .path:
                return .none

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
        .forEach(\.path, action: \.path)
        .forEach(\.days, action: \.days) {
            DayFeature()
        }
    }
    
}



struct DaysView: View {

    @Bindable var store: StoreOf<DaysFeature>

    var body: some View {
        NavigationStack(
          path: $store.scope(state: \.path, action: \.path)
        ) {
          VStack {
              Button {
                  store.send(.addDayButtonTapped)
                  print( store.state )
              } label: {
                      Text("add day")
            }

              List {
                  ForEach(
                    store.scope(state: \.days, action: \.days )
                  ) { dayStore in
                      NavigationLink(state: DaysFeature.Path.State.editDay( dayStore.state )) {
                          Text( "\(dayStore.state.date, style: .date) - Notes: \(dayStore.state.notes.count)" )
                      }
                  }
              }
          }
        } destination: { store in
                switch store.case {
                case let .editDay(dayStore):
                    DayView(store: dayStore)

                case let .editNote(noteStore):
                    NoteView(store: noteStore)
            }
        }
    }
}
