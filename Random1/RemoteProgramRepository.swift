//
//  RemoteProgramRepository.swift
//  Random1
//
//  Created by Joan Domingo on 05.07.17.
//
//

import Foundation
import RxSwift
import Alamofire
import SwiftyJSON

class RemoteProgramRepository: ProgramRepository {
    
    private let programsUrl = "http://www.rac1.cat/audioteca/api/app/v1/programs"
    
    func fetchPrograms() -> Observable<[Program]> {
        return Observable<[Program]>.create({ (observer) -> Disposable in
            let request = Alamofire.request(self.programsUrl)
                .responseJSON(completionHandler: { (response) in
                    if let value = response.result.value {
                        observer.onNext(self.convertJsonToPrograms(value: value))
                        observer.onCompleted()
                    } else if let error = response.result.error {
                        observer.onError(error)
                    }
                })
            return Disposables.create(with: { request.cancel() })
        })
    }
    
    private func convertJsonToPrograms(value: Any) -> [Program] {
        var programList = [Program]()
        
        for jsonProgram in JSON(value)["result"].array! {
            let program = Program(id: jsonProgram["id"].string!,
                                  name: jsonProgram["title"].string!,
                                  imageUrl: jsonProgram["images"]["person-small"].string!,
                                  active: jsonProgram["active"].bool!)
            programList.append(program!)
        }
        
        return programList
    }
    
}
