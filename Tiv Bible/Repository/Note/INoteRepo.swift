//
//  INoteRepo.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

protocol INoteRepo {
    
    func getNotes() -> Observable<[Note]>

    func getNotesByDate(takenOn: String) -> Observable<[Note]>

    func insertNotes(notes: [Note]) -> Observable<Void>
    
    func deleteNotes(notes: [Note]) -> Observable<Void>
    
    func deleteAllNotes() -> Observable<Void>
    
}
