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
    @FetchRequest private var types: FetchedResults<CharacterAttributeType>
    @State private var selectedType: CharacterAttributeType?
    @State private var isEditingTypeName = false
    
    @State private var categories: [CharacterAttributeCategory] = []
    @State private var selectedCategory: CharacterAttributeCategory?
    
    @State private var attributes: [CharacterAttribute] = []
    @State private var selectedAttribute: CharacterAttribute?
    
    private enum FocusField: Int, Hashable {
        case typeName
    }
    @FocusState private var focusedField: FocusField?
    
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
                                .gesture(TapGesture(count: 2).onEnded {
                                    editType(type)
                                })
                                .simultaneousGesture(TapGesture(count: 1).onEnded {
                                    selectedType = type
                                })
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
                    
                    List(categories, id: \.self, selection: $selectedCategory) { category in
                        Text(category.name ?? "")
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
                    
                    List(attributes, id: \.self, selection: $selectedAttribute) { attribute in
                        Text(attribute.name ?? "")
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
            isEditingTypeName = false
            modelManager.attributeTypeModel = EditCharacterAttributeTypeModel(game: game, type: type)
            
            if let unwrappedType = type {
                Task {
                    categories = await EditCharacterAttributeCategoryModel.getCategoriesFromType(type: unwrappedType)
                }
            }
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
