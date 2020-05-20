//
//  Rx+Extensions.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 20/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

extension Realm {
    
    func insertItems<T: Object>(items: [T]) -> Observable<Void> {
        return Observable<Void>.create { observer in
            
            do {
                
                try self.write {
                    self.add(items)
                }
                
                observer.onNext(())
                
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
    
    func deleteItems<T: Object>(items: [T]) -> Observable<Void> {
        
        return Observable<Void>.create { observer in
            
            do {
                
                try self.write {
                    self.delete(items)
                }
                
                observer.onNext(())
                
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
    
    func getSingleElement<T: Object>(primaryKeyValue: String) -> Observable<T?> {
        
        return Observable<T?>.create { observer in
            
            observer.onNext(self.object(ofType: T.self, forPrimaryKey: primaryKeyValue))
            
            return Disposables.create()
        }
    }
    
}
