//
//  MacCharacterAttributeEditor.swift
//  Baxterblex (macOS)
//
//  Created by Alex Seifert on 01.06.22.
//

import SwiftUI

fileprivate final class ModelManager: ObservableObject {
    @Published var attributeTypeModel: EditCharacterAttributeTypeModel
    
    init(game: Game) {
        attributeTypeModel = EditCharacterAttributeTypeModel(game: game)
    }
}

struct MacCharacterAttributeEditor: View {
    @Environment(\.dismiss) var dismiss
    
    var character: Character
    var game: Game

    @ObservedObject private var modelManager: ModelManager
    @State private var selectedType: CharacterAttributeType?
    @State private var isEditingTypeName = false
    @State private var selectedCategory: CharacterAttributeCategory?
    @State private var selectedAttribute: CharacterAttribute?
    
    private enum FocusField: Int, Hashable {
        case typeName
    }
    @FocusState private var focusedField: FocusField?
    
    @FetchRequest private var types: FetchedResults<CharacterAttributeType>
    
    init(character: Character) {
        self.character = character
        self.game = character.game!
        
        self._types = FetchRequest<CharacterAttributeType>(
            sortDescriptors: [NSSortDescriptor(keyPath: \CharacterAttributeType.name, ascending: true)],
            predicate: NSPredicate(format: "game == %@", game),
            animation: .default
        )
        
        self.modelManager = ModelManager(game: game)
    }
    
    var body: some View {
        VStack {
            HSplitView {
                VStack(alignment: .leading) {
                    Text("Types:")
                    
                    List(types, id: \.self, selection: $selectedType) { type in
                        if isEditingTypeName && selectedType == type {
                            TextField("Type Name", text: $modelManager.attributeTypeModel.name)
                                .focused($focusedField, equals: .typeName)
                                .onSubmit { isEditingTypeName = false }
                        }
                        else if let name = type.name {
                            Text(name)
                                .onTapGesture(count: 2) {
                                    editType(type)
                                }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .layoutPriority(1)
                    
                    HStack {
                        Button {
                            modelManager.attributeTypeModel = EditCharacterAttributeTypeModel(game: game)
                            modelManager.attributeTypeModel.save()
                            editType(modelManager.attributeTypeModel.type)
                        } label: {
                            Image(systemName: "plus")
                        }
                        .buttonStyle(.plain)
                        
                        Button {
                            modelManager.attributeTypeModel.promptToDeleteType()
                        } label: {
                            Image(systemName: "minus")
                                .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                        .disabled(selectedType == nil)
                    }
                }
                .frame(minWidth: 150)
                .padding(.horizontal, 10)
                    
                VStack(alignment: .leading) {
                    Text("Categories:")
                    
                    List(types, id: \.self, selection: $selectedType) { type in
                        Text(type.name ?? "")
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .layoutPriority(1)
                    
                    HStack {
                        Button {
                            // Add item
                        } label: {
                            Image(systemName: "plus")
                        }
                        .buttonStyle(.plain)
                        
                        Button {
                            // Remove item
                        } label: {
                            Image(systemName: "minus")
                        }
                        .buttonStyle(.plain)
                    }
                }
                .frame(minWidth: 150)
                .padding(.horizontal, 10)
                
                VStack(alignment: .leading) {
                    Text("Attributes:")
                    
                    List(types, id: \.self, selection: $selectedType) { type in
                        Text(type.name ?? "")
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .layoutPriority(1)
                    
                    HStack {
                        Button {
                            // Add item
                        } label: {
                            Image(systemName: "plus")
                        }
                        .buttonStyle(.plain)
                        
                        Button {
                            // Remove item
                        } label: {
                            Image(systemName: "minus")
                        }
                        .buttonStyle(.plain)
                    }
                }
                .frame(minWidth: 150)
                .padding(.horizontal, 10)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Divider()
                .padding(.vertical, 10)
            
            HStack {
                Spacer()
                
                Button("Done") { dismiss() }
                    .keyboardShortcut(.cancelAction)
            }
        }
        .frame(minWidth: 800, minHeight: 500)
        .padding(20)
        .onChange(of: selectedType) { type in
            modelManager.attributeTypeModel = EditCharacterAttributeTypeModel(game: game, type: type)
        }
    }
    
    private func editType(_ type: CharacterAttributeType) {
        selectedType = type
        isEditingTypeName = true
        focusedField = .typeName
    }
}

struct MacCharacterAttributeEditor_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let character = context.registeredObjects.first(where: { $0 is Character }) as! Character
        
        MacCharacterAttributeEditor(character: character)
    }
}
