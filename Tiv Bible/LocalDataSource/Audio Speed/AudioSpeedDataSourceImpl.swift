//
//  AudioSpeedDataSourceImpl.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 20/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxRealm
import RealmSwift
import RxSwift

struct AudioSpeedDataSourceImpl: IAudioSpeedDataSource {
    
    let realm: Realm
    
    func getAllAudioSpeeds() -> Observable<[AudioSpeed]> {
        return Observable.array(from: realm.objects(AudioSpeed.self))
    }
    
    func getAudioSpeedById(audioSpeedId: String) -> Observable<AudioSpeed> {
        return Observable.from(optional: realm.object(ofType: AudioSpeed.self, forPrimaryKey: audioSpeedId))
    }
    
    func getAudioSpeedByName(name: String) -> Observable<AudioSpeed> {
        return Observable.from(optional: realm.objects(AudioSpeed.self).filter("name LIKE %@", name).first)
    }
    
    func insertAudioSpeeds(audioSpeeds: [AudioSpeed]) -> Observable<Void> {
        return realm.insertItems(items: audioSpeeds)
    }
    
    func deleteAudioSpeeds(audioSpeeds: [AudioSpeed]) -> Observable<Void> {
        return realm.deleteItems(items: audioSpeeds)
    }
}
