//
//  PodcastsInteractor.swift
//  Random1
//
//  Created by Joan Domingo on 11.07.17.
//
//

import RxSwift

protocol PodcastRepository {
    func fetchPodcasts(program: Program) -> Observable<[Podcast]>
}

class PodcastsInteractor {
    
    private let podcastRepository: PodcastRepository
    
    init() {
        podcastRepository = RemotePodcastRepository()
    }
    
    func loadPodcasts(program: Program) -> Observable<[Podcast]> {
        return podcastRepository.fetchPodcasts(program: program)
    }
    
}
