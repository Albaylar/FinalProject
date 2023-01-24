//
//  NoteViewModel.swift
//  SimpraFinalProject
//
//  Created by Furkan Deniz Albaylar on 24.01.2023.
//

import Foundation
//  Created by Furkan Deniz Albaylar on 23.01.2023.
//

import Foundation

//MARK: - Protocols
protocol NoteViewModelProtocol {
    var delegate: NoteViewModelDelegate? { get set }
    func fetchNotes()
    func getNoteCount() -> Int
    func getNote(at index: Int) -> Note?
    func deleteNote(at index:Int)
    func editNote(obj:Note, newObj:NoteModel)
    
    func getGameId(at index: Int) -> Int?
    
    
}

protocol NoteViewModelDelegate: AnyObject {
    func notesLoaded()
}

//MARK: - Classes
final class NoteViewModel: NoteViewModelProtocol {
    weak var delegate: NoteViewModelDelegate?
    private var notes = [Note]()
    
    func fetchNotes() {
        Globals.sharedInstance.isNotesChanged = false
        notes = NoteCoreDataManager.shared.getNotes()
        notes = notes.reversed()
        delegate?.notesLoaded()
    }
    
    func getNoteCount() -> Int {
        notes.count
    }
    
    func getNote(at index: Int) -> Note? {
        if index > notes.count - 1{
            return nil
        }
        return notes[index]
    }
    
    func deleteNote(at index:Int){
        NoteCoreDataManager.shared.deleteNote(note: notes[index])
        notes.remove(at: index)
        delegate?.notesLoaded()
        
    }
    
    func editNote(obj:Note, newObj:NoteModel){
        NoteCoreDataManager.shared.editNote(obj: obj,newObj: newObj)
    }
    
    func getGameId(at index: Int) -> Int? {
        if index > notes.count - 1{
            return nil
        }
        return Int(notes[index].gameId)
    }
}
