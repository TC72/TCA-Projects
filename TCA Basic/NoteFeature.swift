import ComposableArchitecture
import SwiftUI

@Reducer
struct NoteFeature {
    
    @ObservableState
    struct State: Identifiable {
        var id: UUID
        var noteText: String
    }
    
    enum Action {
        case noteTextChanged(String)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .noteTextChanged(text):
                state.noteText = text
                return .none
            }
        }        ._printChanges()

    }
}

struct NoteView: View {
    
    @Bindable var store: StoreOf<NoteFeature>
    
    var body: some View {
        VStack {
            TextField("Note", text: $store.noteText.sending(\.noteTextChanged))
        }
        Spacer(minLength: 10)
        
    }
}
