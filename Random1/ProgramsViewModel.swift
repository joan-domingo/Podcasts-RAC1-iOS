//
//  ProgramsViewModel.swift
//  Random1
//
//  Created by Joan Domingo on 29.06.17.
//
//

import Foundation
import RxSwift

protocol ProgramsViewModelType: class {
    var programs: Observable<[Program]> { get }
}

class ProgramsViewModel: ProgramsViewModelType {
    
    let programs: Observable<[Program]>
    
    private let programsInteractor: ProgramsInteractor
    
    init(programsInteractor: ProgramsInteractor = ProgramsInteractor()) {
        self.programsInteractor = programsInteractor
        
        self.programs = self.programsInteractor.loadPrograms()
            .catchError { error in
                print("Error: \(error)")
                return Observable.just([])
            }
            .observeOn(MainScheduler.instance)
    }
    
}
