//
//  PodcastsViewModel.swift
//  Random1
//
//  Created by Joan Domingo on 11.07.17.
//
//

import Foundation
import RxSwift

protocol PodcastsViewModelType: class {
    var podcasts: Observable<[Podcast]> { get }
}

class PodcastsViewModel: PodcastsViewModelType {
    var podcasts: Observable<[Podcast]>
    
    private let podcastsInteractor: PodcastsInteractor
    
    init(program: Program, podcastsInteractor: PodcastsInteractor = PodcastsInteractor()) {
        self.podcastsInteractor = podcastsInteractor
        
        self.podcasts = self.podcastsInteractor.loadPodcasts(program: program)
            .observeOn(MainScheduler.instance)
    }
    
}
