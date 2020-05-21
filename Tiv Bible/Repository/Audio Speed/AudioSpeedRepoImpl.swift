//
//  AudioSpeedImpl.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

struct AudioSpeedRepoImpl: IAudioSpeedRepo {
    
    let audioSpeedDataSource: IAudioSpeedDataSource
    
    func getAllAudioSpeeds() -> Observable<[AudioSpeed]> {
        audioSpeedDataSource.getAllAudioSpeeds()
    }
    
    func getAudioSpeedById(audioSpeedId: String) -> Observable<AudioSpeed> {
        audioSpeedDataSource.getAudioSpeedById(audioSpeedId: audioSpeedId)
    }
    
    func getAudioSpeedByName(name: String) -> Observable<AudioSpeed> {
        audioSpeedDataSource.getAudioSpeedByName(name: name)
    }
    
    func insertAudioSpeeds(audioSpeeds: [AudioSpeed]) -> Observable<Void> {
        audioSpeedDataSource.insertAudioSpeeds(audioSpeeds: audioSpeeds)
    }
    
    func deleteAudioSpeeds(audioSpeeds: [AudioSpeed]) -> Observable<Void> {
        audioSpeedDataSource.deleteAudioSpeeds(audioSpeeds: audioSpeeds)
    }
    
    func deleteAllAudioSpeeds() -> Observable<Void> {
        audioSpeedDataSource.deleteAllAudioSpeeds()
    }
    
}
