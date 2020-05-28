//
//  BookRepoImpl.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

struct BookRepoImpl: IBookRepo {
    
    let bookDataSource: IBookDataSource
    
    func getAllBooks() -> Observable<[Book]> {
        bookDataSource.getAllBooks()
    }
    
    func getBookById(bookId: String) -> Observable<Book> {
        bookDataSource.getBookById(bookId: bookId)
    }
    
    func getBooksByTestament(testamentId: String) -> Observable<[Book]> {
        bookDataSource.getBooksByTestament(testamentId: testamentId)
    }
    
    func getBooksByVersion(versionId: String) -> Observable<[Book]> {
        bookDataSource.getBooksByVersion(versionId: versionId)
    }
    
    func getBookByName(bookName: String) -> Observable<Book> {
        bookDataSource.getBookByName(bookName: bookName)
    }
    
    func getBooksByTestamentAndVersion(testamentId: String, versionId: String) -> Observable<[Book]> {
        bookDataSource.getBooksByTestamentAndVersion(testamentId: testamentId, versionId: versionId)
    }
    
    func insertBooks(books: [Book]) -> Observable<Void> {
        bookDataSource.insertBooks(books: books)
    }
    
    func deleteBooks(books: [Book]) -> Observable<Void> {
        bookDataSource.deleteBooks(books: books)
    }
    
    func deleteAllBooks() -> Observable<Void> {
        bookDataSource.deleteAllBooks()
    }
    
}
