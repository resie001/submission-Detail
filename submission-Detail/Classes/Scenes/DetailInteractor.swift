//
//  DetailInteractor.swift
//  submission-Detail
//
//  Created by Ade Resie on 24/12/22.
//

import Foundation
import submission_Core
import RxSwift

class DetailInteractor: DetailPresenterToInteractorProtocol {
    var presenter: DetailInteractorToPresenterProtocol?
    var repository: GameRepositoryProtocol?
    
    private let url = Constants.BaseUrl + "games"
    private let disposeBag = DisposeBag()
    
    func fetchGameDetail(id: Float) {
        repository?.fetchGameDetail(id: id)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] result in
                guard let self = self else { return }
                self.presenter?.gameResult(games: result, isSuccess: true, message: nil)
            } onError: { [weak self] error in
                guard let self = self else { return }
                self.presenter?.gameResult(games: nil, isSuccess: false, message: error.localizedDescription)
            }
            .disposed(by: disposeBag)
    }
}
