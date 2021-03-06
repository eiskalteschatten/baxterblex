//
//  EditGameModel.swift
//  Baxterblex
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI
import CoreData

final class EditGameModel: AbstractEditModel {
    private var game: Game?
    
    @Published var picture: ImageStore?
    @Published var name: String = ""
    @Published var addStartDate: Bool = false
    @Published var startDate: Date = Date()
    @Published var addEndDate: Bool = false
    @Published var endDate: Date = Date()
    @Published var archived: Bool = false
    
    init(game: Game? = nil) {
        super.init()
        self.game = game
        initVariables()
    }
    
    override func initVariables() {
        if let unwrapped = game {
            picture = unwrapped.picture
            name = unwrapped.name ?? name
            addStartDate = unwrapped.startDate != nil
            startDate = unwrapped.startDate ?? startDate
            addEndDate = unwrapped.endDate != nil
            endDate = unwrapped.endDate ?? endDate
            archived = unwrapped.archived
        }
    }
    
    override func save() {
        withAnimation {
            game = game != nil ? game : Game(context: viewContext!)
            
            game!.createdAt = Date()
            game!.updatedAt = Date()
            
            game!.picture = picture
            game!.name = name
            game!.startDate = addStartDate ? startDate : nil
            game!.endDate = addEndDate ? endDate : nil
            game!.archived = archived

            do {
                try viewContext!.save()
            } catch {
                // TODO
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func getPictureImageStore(data: Data) -> ImageStore {
        if let unwrappedImage = game!.picture {
            unwrappedImage.updatedAt = Date()
            unwrappedImage.image = data
            return unwrappedImage
        }
        else {
            let image = ImageStore(context: viewContext!)
            image.createdAt = Date()
            image.updatedAt = Date()
            image.image = data
            return image
        }
    }
}
