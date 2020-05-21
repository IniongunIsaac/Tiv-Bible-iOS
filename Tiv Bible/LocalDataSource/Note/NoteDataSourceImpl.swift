//
//  NoteDataSourceImpl.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxRealm
import RealmSwift
import RxSwift

struct NoteDataSourceImpl: INoteDataSource {
    
    let realm: Realm
    
    func getNotes() -> Observable<[Note]> {
        Observable.array(from: realm.objects(Note.self))
    }
    
    func getNotesByDate(takenOn: String) -> Observable<[Note]> {
        Observable.array(from: realm.objects(Note.self).filter("takenOn == %@", takenOn).sorted(byKeyPath: "takenOn", ascending: false))
    }
    
    func insertNotes(notes: [Note]) -> Observable<Void> {
        realm.insertItems(items: notes)
    }
    
    func deleteNotes(notes: [Note]) -> Observable<Void> {
        realm.deleteItems(items: notes)
    }
    
    func deleteAllNotes() -> Observable<Void> {
        realm.deleteAllItems(for: Note.self)
    }
    
}
