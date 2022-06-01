//
//  MacCharacterAttributeEditor.swift
//  Baxterblex (macOS)
//
//  Created by Alex Seifert on 01.06.22.
//

import SwiftUI

fileprivate final class ModelManager: ObservableObject {
    @Published var attributeTypeModel: EditCharacterAttributeTypeModel
    
    init(character: Character) {
        attributeTypeModel = EditCharacterAttributeTypeModel(character: character)
    }
}

struct MacCharacterAttributeEditor: View {
    @Environment(\.dismiss) var dismiss
    
    var character: Character

    @ObservedObject private var modelManager: ModelManager
    @State private var selectedType: CharacterAttributeType?
    @State private var selectedCategory: CharacterAttributeCategory?
    @State private var selectedAttribute: CharacterAttribute?
    
    @FetchRequest private var types: FetchedResults<CharacterAttributeType>
    
    init(character: Character) {
        self.character = character
        
        self._types = FetchRequest<CharacterAttributeType>(
            sortDescriptors: [NSSortDescriptor(keyPath: \CharacterAttributeType.name, ascending: true)],
            predicate: NSPredicate(format: "character == %@", character),
            animation: .default
        )
        
        self.modelManager = ModelManager(character: character)
    }
    
    var body: some View {
        VStack {
            HSplitView {
                VStack(alignment: .leading) {
                    Text("Types:")
                    
                    List(types, id: \.self, selection: $selectedType) { type in
                        if let name = type.name, !name.isEmpty {
                            Text(name)
                        }
                        else {
                            TextField("Type Name", text: $modelManager.attributeTypeModel.name)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .layoutPriority(1)
                    
                    HStack {
                        Button {
                            modelManager.attributeTypeModel = EditCharacterAttributeTypeModel(character: character)
                            modelManager.attributeTypeModel.save()
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
            modelManager.attributeTypeModel = EditCharacterAttributeTypeModel(character: character, type: type)
        }
    }
}

struct MacCharacterAttributeEditor_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let character = context.registeredObjects.first(where: { $0 is Character }) as! Character
        
        MacCharacterAttributeEditor(character: character)
    }
}
