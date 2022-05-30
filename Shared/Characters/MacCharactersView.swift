//
//  MacCharactersView.swift
//  Baxterblex (macOS)
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

struct MacCharactersView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var gameStore: GameStore
    
    var game: Game
    
    @SectionedFetchRequest private var sectionedCharacters: SectionedFetchResults<String?, Character>
    
    init(game: Game) {
        self._sectionedCharacters = SectionedFetchRequest<String?, Character>(
            sectionIdentifier: \.status,
            sortDescriptors: [NSSortDescriptor(keyPath: \Character.status, ascending: true),
                              NSSortDescriptor(keyPath: \Character.name, ascending: true)],
            predicate: NSPredicate(format: "game == %@", game),
            animation: .default
        )
        self.game = game
    }
    
    var body: some View {
        HSplitView {
            List(sectionedCharacters, selection: $gameStore.selectedCharacter) { section in
                if let rawStatus = section.id {
                    let enumStatus = CharacterStatuses(rawValue: rawStatus)!
                    let status = characterStatusLabels[enumStatus]!
                    
                    Section(status) {
                        ForEach(section, id: \.self) { character in
                            CharacterListItem(character: character)
                        }
                    }
                }
                else {
                    Section("No Status") {
                        ForEach(section, id: \.self) { character in
                            CharacterListItem(character: character)
                        }
                    }
                }
            }
            .frame(minWidth: 250, idealWidth: 300, maxHeight: .infinity)
            .listStyle(.sidebar)

            // Use a VStack so that the HSplitView doesn't move when switching between the two views within
            VStack {
                if gameStore.selectedCharacter != nil {
                    EditCharacterView()
                        .padding(15)
                }
                else {
                    VStack(spacing: 25) {
                        Text("No character selected")
                        
                        Button {
                            gameStore.selectedCharacter = Character(context: viewContext)
                        } label : {
                            Label("Create a Character", systemImage: "person.badge.plus")
                        }
                        .buttonStyle(RoundedFlatButtonStyle())
                    }
                }
            }
            .frame(minWidth: 300, maxWidth: .infinity, maxHeight: .infinity)
            .layoutPriority(1)
        }
    }
}

fileprivate struct CharacterListItem: View {
    @EnvironmentObject var gameStore: GameStore
    
    var character: Character
    @State private var presentDeleteAlert = false
    @State private var characterToDelete: Character?
    
    var body: some View {
        HStack {
            Group {
                if let unwrappedImageStore = character.picture, let picture = unwrappedImageStore.image {
                    let image = NSImage(data: picture)
                    Image(nsImage: image!)
                        .resizable()
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                }
                else {
                    Image(systemName: DEFAULT_CHARACTER_IMAGE_NAME)
                        .font(.system(size: 35))
                }
            }
            .clipped()
            .aspectRatio(1, contentMode: .fit)
            .frame(width: 35, height: 35)
            .padding(.trailing, 5)
            .padding(.vertical, 2)
            
            Text(character.name ?? DEFAULT_CHARACTER_NAME)
                .font(.system(size: 13))
        }
        .contextMenu {
            Button("Delete Character", role: .destructive, action: { promptToDeleteCharacter(character) })
        }
    }
    
    private func promptToDeleteCharacter(_ character: Character) {
        let alert = NSAlert()
        alert.messageText = "Are you sure you want to delete this character?"
        alert.informativeText = "This cannot be undone."
        alert.addButton(withTitle: "No")
        alert.addButton(withTitle: "Yes")
        alert.alertStyle = .warning
        
        let delete = alert.runModal() == NSApplication.ModalResponse.alertSecondButtonReturn
        
        if delete {
            EditCharacterModel.deleteCharacter(character)
        }
    }
}

struct MacCharactersView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let game = context.registeredObjects.first(where: { $0 is Game }) as! Game
        
        MacCharactersView(game: game)
    }
}
