//
//  NoteDetailViewModel.swift
//  SimpraFinalProject

//  Created by Furkan Deniz Albaylar on 23.01.2023.
//

import Foundation

//MARK: - Protocols
protocol NoteDetailViewModelProtocol {
    var delegate: NoteDetailViewModelDelegate? { get set }
    func newNote(obj:NoteModel)
    func editNote(obj:Note, newObj:NoteModel)
}

protocol NoteDetailViewModelDelegate: AnyObject {
    func notesLoaded()
}

//MARK: - Classes
final class NoteDetailViewModel: NoteDetailViewModelProtocol {
    weak var delegate: NoteDetailViewModelDelegate?
    private var notes = [Note]()
    
    func newNote(obj: NoteModel) {
        _ = NoteCoreDataManager.shared.saveNote(obj: obj)
    }
    
    
    func editNote(obj:Note, newObj:NoteModel){
        NoteCoreDataManager.shared.editNote(obj: obj,newObj: newObj)
    }
    
}
