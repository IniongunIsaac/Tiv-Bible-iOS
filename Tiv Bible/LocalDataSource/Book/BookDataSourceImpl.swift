//
//  BookDataSourceImpl.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxRealm
import RealmSwift
import RxSwift

struct BookDataSourceImpl: IBookDataSource {
    
    let realm: Realm
    
    func getAllBooks() -> Observable<[Book]> {
        return Observable.array(from: realm.objects(Book.self))
    }
    
    func getBooksByTestament(testamentId: String) -> Observable<[Book]> {
        return Observable.array(from: realm.objects(Book.self).filter("testament.id = %@", testamentId))
    }
    
    func getBooksByVersion(versionId: String) -> Observable<[Book]> {
        return Observable.array(from: realm.objects(Book.self).filter("version.id = %@", versionId))
    }
    
    func getBookByName(bookName: String) -> Observable<Book> {
        return Observable.from(optional: realm.objects(Book.self).filter("name LIKE %@", bookName).first)
    }
    
    func getBooksByTestamentAndVersion(testamentId: String, versionId: String) -> Observable<[Book]> {
        return Observable.array(from: realm.objects(Book.self).filter("testament.id = %@ AND version.id = %@", testamentId, versionId))
    }
    
    func insertBooks(books: [Book]) -> Observable<Void> {
        return realm.insertItems(items: books)
    }
    
    func deleteBooks(books: [Book]) -> Observable<Void> {
        return realm.deleteItems(items: books)
    }
    
    
}
