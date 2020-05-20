//
//  IAudioSpeedDataSource.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 20/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

protocol IAudioSpeedDataSource {
    
    func getAllAudioSpeeds() -> Observable<[AudioSpeed]>
    
    func getAudioSpeedById(audioSpeedId: String) -> Observable<AudioSpeed>
    
    func getAudioSpeedByName(name: String) -> Observable<AudioSpeed>
    
    func insertAudioSpeeds(audioSpeeds: [AudioSpeed]) -> Observable<Void>
    
    func deleteAudioSpeeds(audioSpeeds: [AudioSpeed]) -> Observable<Void>
}
