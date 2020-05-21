//
//  NoteRepoImpl.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

struct NoteRepoImpl: INoteRepo {
    
    let noteDataSource: INoteDataSource
    
    func getNotes() -> Observable<[Note]> {
        noteDataSource.getNotes()
    }
    
    func getNotesByDate(takenOn: String) -> Observable<[Note]> {
        noteDataSource.getNotesByDate(takenOn: takenOn)
    }
    
    func insertNotes(notes: [Note]) -> Observable<Void> {
        noteDataSource.insertNotes(notes: notes)
    }
    
    func deleteNotes(notes: [Note]) -> Observable<Void> {
        noteDataSource.deleteNotes(notes: notes)
    }
    
    func deleteAllNotes() -> Observable<Void> {
        noteDataSource.deleteAllNotes()
    }
    
}
