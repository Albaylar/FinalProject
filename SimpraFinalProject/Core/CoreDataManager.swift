//
//  CoreDataManager.swift
//  SimpraFinalProject
//
//  Created by Furkan Deniz Albaylar on 24.01.2023.
//

import Foundation
import UIKit
import CoreData

final class FavoriteCoreDataManager {
    // MARK: - Shared
    static let shared = FavoriteCoreDataManager()
    private let managedContext: NSManagedObjectContext!
    
    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    // MARK: - Favorite
    func saveFavorite(gameId:Int, imageId:String) -> Bool? {
        let entity = NSEntityDescription.entity(forEntityName: "Favorite", in: managedContext)!
        let game = NSManagedObject(entity: entity, insertInto: managedContext)
        game.setValue(gameId, forKey: "gameId")
        game.setValue(imageId, forKey: "imageId")
        
        do {
            try managedContext.save()
            return true
        } catch let error as NSError {
            NotificationCenter.default.post(name: NSNotification.Name("detailGamesErrorMessage"), object: error.localizedDescription)
            return nil
        }
    }
    
    func getFavorites() -> [Favorite] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
        do {
            let games = try managedContext.fetch(fetchRequest)
            return games as! [Favorite]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            NotificationCenter.default.post(name: NSNotification.Name("favoriteGamesErrorMessage"), object: error.localizedDescription)
        }
        return []
    }
    
    func deleteFavorite(game: Favorite) {
        managedContext.delete(game)
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            NotificationCenter.default.post(name: NSNotification.Name("favoriteGamesErrorMessage"), object: error.localizedDescription)
        }
    }
    
    func editFavorite(obj: Favorite, imageId:String) {
        let game = managedContext.object(with: obj.objectID)
        game.setValue(imageId, forKey: "imageId")
        do {
            try managedContext.save()
        } catch let error as NSError {
            NotificationCenter.default.post(name: NSNotification.Name("favoriteGamesErrorMessage"), object: error.localizedDescription)
        }
    }
    
    func isFavorite(_ id:Int) -> Bool?{
        let fetchRequest: NSFetchRequest<Favorite>
        fetchRequest = Favorite.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(
            format: "gameId = %d", id
        )
        do {
            let objects = try managedContext.fetch(fetchRequest)
            if objects.count > 0{
                return true
            }
            return false
        } catch let error as NSError {
            NotificationCenter.default.post(name: NSNotification.Name("detailGamesErrorMessage"), object: error.localizedDescription)
            return nil
        }
    }
    
    func deleteFavoriteWithId(id:Int) -> Bool?{
        let fetchRequest: NSFetchRequest<Favorite>
        fetchRequest = Favorite.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(
            format: "gameId = %d", id)
        do {
            let objects = try managedContext.fetch(fetchRequest)
            for game in objects{
                deleteFavorite(game: game)
            }
            return false
        } catch let error as NSError {
            NotificationCenter.default.post(name: NSNotification.Name("detailGamesErrorMessage"), object: error.localizedDescription)
            return nil
        }
    }
}


//final class NoteCoreDataManager {
    // MARK: - Shared
    //  static let shared = NoteCoreDataManager()
// private let managedContext: NSManagedObjectContext!
    
    //private init() {
    //  let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //  managedContext = appDelegate.persistentContainer.viewContext
    //}
    
    // MARK: - Note
    // func saveNote(obj: NoteModel) -> Note? {
    //  let entity = NSEntityDescription.entity(forEntityName: "Note", in: managedContext)!
    //  let note = NSManagedObject(entity: entity, insertInto: managedContext)
    //  note.setValue(obj.gameId, forKey: "gameId")
    //  note.setValue(obj.gameTitle, forKey: "gameTitle")
    //  note.setValue(obj.imageId, forKey: "imageId")
    //    note.setValue(obj.imageUrl, forKey: "imageUrl")
    //  note.setValue(obj.noteTitle, forKey: "noteTitle")
    //  note.setValue(obj.noteDetail, forKey: "noteDetail")
        
    //    do {
    //      try managedContext.save()
    //      return note as? Note
    //   } catch let error as NSError {
    //      NotificationCenter.default.post(name: NSNotification.Name("noteGamesErrorMessage"), object: error.localizedDescription)
//    }
        
//   return nil
//  }
    
//  func getNotes() -> [Note] {
//      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Note")
//      do {
//          let notes = try managedContext.fetch(fetchRequest)
//          return notes as! [Note]
//      } catch let error as NSError {
//          NotificationCenter.default.post(name: NSNotification.Name("noteGamesErrorMessage"), object: //error.localizedDescription)
//      }
//      return []
//  }
//
//  func deleteNote(note: Note) {
//      managedContext.delete(note)
//
//      do {
//          try managedContext.save()
//      } catch let error as NSError {
//          NotificationCenter.default.post(name: NSNotification.Name("noteGamesErrorMessage"), object: error.localizedDescription)
//   }
//  }
    
   // func editNote(obj: Note, newObj: NoteModel) {
    //    let note = managedContext.object(with: obj.objectID)
    //    note.setValue(newObj.gameId, forKey: "gameId")
    //    note.setValue(newObj.gameTitle, forKey: "gameTitle")
    //  note.setValue(newObj.imageId, forKey: "imageId")
    //  note.setValue(newObj.imageUrl, forKey: "imageUrl")
    //  note.setValue(newObj.noteTitle, forKey: "noteTitle")
    //  note.setValue(newObj.noteDetail, forKey: "noteDetail")
        
    //   do {
    //      try managedContext.save()
    //  } catch let error as NSError {
    //      NotificationCenter.default.post(name: NSNotification.Name("noteGamesErrorMessage"), object: //error.localizedDescription)
    // }
    // }
    
//}


