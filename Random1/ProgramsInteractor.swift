//
//  ProgramsInteractor.swift
//  Random1
//
//  Created by Joan Domingo on 04.07.17.
//
//

import RxSwift

protocol ProgramRepository {
    func fetchPrograms() -> Observable<[Program]>
}

class ProgramsInteractor {
    
    private let programRepository: ProgramRepository
    
    init() {
        programRepository = RemoteProgramRepository()
    }
    
    func loadPrograms() -> Observable<[Program]> {
        return programRepository.fetchPrograms()
            .flatMap { programs -> Observable<Program> in
                return Observable.from(programs)
            }
            .filter { p -> Bool in p.active == true}
            .toArray()
    }
    
}
