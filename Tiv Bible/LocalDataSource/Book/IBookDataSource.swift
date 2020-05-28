//
//  IBookDataSource.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

protocol IBookDataSource {
    
    func getAllBooks() -> Observable<[Book]>
    
    func getBookById(bookId: String) -> Observable<Book>
    
    func getBooksByTestament(testamentId: String) -> Observable<[Book]>

    func getBooksByVersion(versionId: String) -> Observable<[Book]>

    func getBookByName(bookName: String) -> Observable<Book>

    func getBooksByTestamentAndVersion(testamentId: String, versionId: String) -> Observable<[Book]>

    func insertBooks(books: [Book]) -> Observable<Void>

    func deleteBooks(books: [Book]) -> Observable<Void>
    
    func deleteAllBooks() -> Observable<Void>

}
