//
//  ProgramsInteractor.swift
//  Random1
//
//  Created by Joan Domingo on 04.07.17.
//
//

import RxSwift

class ProgramsInteractor {
    
    func loadPrograms() -> Observable<[Program]> {
        let program1 = Program(id: "p1", name: "program1", imageUrl: "http://example.com/image")
        let program2 = Program(id: "p2", name: "program2", imageUrl: "http://example.com/image")
        
        var programList = [Program]()
        programList.append(program1!)
        programList.append(program2!)
        
        return Observable.from(optional: programList)
    }
    
}
