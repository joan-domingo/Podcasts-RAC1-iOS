//
//  RemotePodcastRepository.swift
//  Random1
//
//  Created by Joan Domingo on 11.07.17.
//
//

import Foundation
import RxSwift
import Alamofire
import SwiftyJSON

class RemotePodcastRepository: PodcastRepository {
    
    private let podcastsUrl = "http://www.rac1.cat/audioteca/api/app/v1/sessions/"
    
    func fetchPodcasts(program: Program) -> Observable<[Podcast]> {
        return Observable<[Podcast]>.create({ (observer) -> Disposable in
            let request = Alamofire.request(self.podcastsUrl + program.id)
                .responseJSON(completionHandler: { (response) in
                    if let value = response.result.value {
                        observer.onNext(self.convertJsonToPodcasts(value: value, program: program))
                        observer.onCompleted()
                    } else if let error = response.result.error {
                        observer.onError(error)
                    }
                })
            return Disposables.create(with: { request.cancel() })
        })
    }
    
    private func convertJsonToPodcasts(value: Any, program: Program) -> [Podcast] {
        var podcastList = [Podcast]()
        
        for jsonPodcast in JSON(value)["result"].array! {
            let podcast = Podcast(id: jsonPodcast["audio"]["id"].string!,
                                  title: jsonPodcast["appMobileTitle"].string!,
                                  imageUrl: program.imageUrl,
                                  audioUrl: jsonPodcast["path"].string!)
            podcastList.append(podcast)
        }
        
        return podcastList
    }
    
}
