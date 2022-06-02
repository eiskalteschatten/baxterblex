//
//  MacCharacterAttributeEditor.swift
//  Baxterblex (macOS)
//
//  Created by Alex Seifert on 01.06.22.
//

import SwiftUI

fileprivate final class ModelManager: ObservableObject {
    @Published var attributeTypeModel: EditCharacterAttributeTypeModel
    @Published var attributeCategoryModel: EditCharacterAttributeCategoryModel
    @Published var attributeModel: EditCharacterAttributeModel
    
    init(game: Game) {
        let _attributeTypeModel = EditCharacterAttributeTypeModel(game: game)
        attributeTypeModel = _attributeTypeModel
        
        let _attributeCategoryModel = EditCharacterAttributeCategoryModel(type: _attributeTypeModel.type)
        attributeCategoryModel = _attributeCategoryModel
        
        attributeModel = EditCharacterAttributeModel(category: _attributeCategoryModel.category)
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
    @State private var isEditingCategoryName = false
    
    @State private var attributes: [CharacterAttribute] = []
    @State private var selectedAttribute: CharacterAttribute?
    
    private enum FocusField: Int, Hashable {
        case typeName, categoryName
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
                        if isEditingTypeName && modelManager.attributeTypeModel.type == type {
                            TextField("Skills, Stats, etc", text: $modelManager.attributeTypeModel.name)
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
                            modelManager.attributeTypeModel.promptToDelete()
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
                        if isEditingCategoryName && modelManager.attributeCategoryModel.category == category {
                            TextField("Empathy, Tech, etc", text: $modelManager.attributeCategoryModel.name)
                                .focused($focusedField, equals: .categoryName)
                                .onSubmit { isEditingCategoryName = false }
                        }
                        else if let name = category.name {
                            Text(name)
                                .gesture(TapGesture(count: 2).onEnded {
                                    editCategory(category)
                                })
                                .simultaneousGesture(TapGesture(count: 1).onEnded {
                                    selectedCategory = category
                                })
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .layoutPriority(1)
                    
                    HStack {
                        Button {
                            if let unwrappedType = selectedType {
                                modelManager.attributeCategoryModel = EditCharacterAttributeCategoryModel(type: unwrappedType)
                                modelManager.attributeCategoryModel.save()
                                
                                Task {
                                    categories = await EditCharacterAttributeCategoryModel.getCategoriesFromType(unwrappedType)
                                    editCategory(modelManager.attributeCategoryModel.category)
                                }
                            }
                        } label: {
                            Image(systemName: "plus")
                        }
                        .buttonStyle(.plain)
                        .disabled(selectedType == nil)
                        
                        Button {
                            modelManager.attributeCategoryModel.promptToDelete()
                        } label: {
                            Image(systemName: "minus")
                        }
                        .buttonStyle(.plain)
                        .disabled(selectedCategory == nil)
                    }
                }
                .frame(minWidth: 150)
                .padding(.horizontal, 10)
                
                VStack(alignment: .leading) {
                    Text("Attributes:")
                    
                    List(attributes, id: \.self, selection: $selectedAttribute) { attribute in
                        MacEditCharacterAttributeListItem(
                            attribute: attribute,
                            selectedAttribute: $selectedAttribute,
                            attributeModel: $modelManager.attributeModel
                        )
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .layoutPriority(1)
                    
                    HStack {
                        Button {
                            if let unwrappedCategory = selectedCategory {
                                modelManager.attributeModel = EditCharacterAttributeModel(category: unwrappedCategory)
                                modelManager.attributeModel.save()
                                
                                Task {
                                    attributes = await EditCharacterAttributeModel.getAttributesFromCategory(unwrappedCategory)
                                    editAttribute(modelManager.attributeModel.attribute)
                                }
                            }
                        } label: {
                            Image(systemName: "plus")
                        }
                        .buttonStyle(.plain)
                        .disabled(selectedCategory == nil)
                        
                        Button {
                            modelManager.attributeModel.promptToDelete()
                        } label: {
                            Image(systemName: "minus")
                        }
                        .buttonStyle(.plain)
                        .disabled(selectedAttribute == nil)
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
            selectedCategory = nil
            selectedAttribute = nil
            
            if let unwrappedType = type {
                Task {
                    categories = await EditCharacterAttributeCategoryModel.getCategoriesFromType(unwrappedType)
                }
            }
            else {
                categories = []
            }
        }
        .onChange(of: selectedCategory) { category in
            if let type = selectedType {
                modelManager.attributeCategoryModel = EditCharacterAttributeCategoryModel(type: type, category: category)
                selectedAttribute = nil
               
                if let unwrappedCategory = category {
                    Task {
                        attributes = await EditCharacterAttributeModel.getAttributesFromCategory(unwrappedCategory)
                    }
                }
                else {
                    attributes = []
                }
            }
        }
        .onChange(of: selectedAttribute) { attribute in
            if let category = selectedCategory {
                modelManager.attributeModel = EditCharacterAttributeModel(category: category, attribute: attribute)
            }
        }
    }
    
    private func editType(_ type: CharacterAttributeType) {
        selectedType = type
        isEditingTypeName = true
        focusedField = .typeName
    }
    
    private func editCategory(_ category: CharacterAttributeCategory) {
        selectedCategory = category
        isEditingCategoryName = true
        focusedField = .categoryName
    }
    
    private func editAttribute(_ attribute: CharacterAttribute) {
        selectedAttribute = attribute
    }
}

struct MacCharacterAttributeEditor_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let character = context.registeredObjects.first(where: { $0 is Character }) as! Character
        
        MacCharacterAttributeEditor(character: character)
    }
}
