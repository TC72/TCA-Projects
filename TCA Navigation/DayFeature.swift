import ComposableArchitecture
import SwiftUI

@Reducer
struct DayFeature {
    
    @ObservableState
    struct State: Identifiable {
        var id: UUID
        var date: Date
        var notes: IdentifiedArrayOf<NoteFeature.State> = []
    }
    
    enum Action {
        case notes(IdentifiedActionOf<NoteFeature>)
        case addNoteButtonTapped
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
                
            case .notes:
                return .none
                
            case .addNoteButtonTapped:
                state.notes.append(
                    NoteFeature.State(
                        id: UUID(),
                        noteText: "Default Text"
                    )
                )
                return .none
                
            }
        }
        .forEach(\.notes, action: \.notes) {
            NoteFeature()
        }
    }
    
    
    
}

struct DayView: View {
    
    var store: StoreOf<DayFeature>
    
    var body: some View {
        VStack {
            Text( "Notes: \(store.notes.count)")
            Button {
                store.send(.addNoteButtonTapped)
            } label: {
                Text("add note")
            }
            

              List {
                  ForEach(
                    store.scope(state: \.notes, action: \.notes )
                  ) { noteStore in
                      NavigationLink(state: DaysFeature.Path.State.editNote( noteStore.state )) {
                          Text( "Note: \(noteStore.state.noteText)" )
                      }
                  }
              }
            Spacer(minLength: 20)
        }
    }
}
