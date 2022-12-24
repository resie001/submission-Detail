//
//  DetailPresenter.swift
//  submission-Detail
//
//  Created by Ade Resie on 24/12/22.
//

import Foundation
import submission_Core

class DetailPresenter: DetailViewToPresenterProtocol {
    var router: DetailPresenterToRouterProtocol?
    var interactor: DetailPresenterToInteractorProtocol?
    var view: DetailPresenterToViewProtocol?
    var games: GameDetailModel!
    
    func fetchDetail(id: Float) {
        interactor?.fetchGameDetail(id: id)
    }
}

extension DetailPresenter: DetailInteractorToPresenterProtocol {
    func gameResult(games: GameResponse?, isSuccess: Bool, message: String?) {
        if isSuccess {
            self.games = GameMapper.mapGameResponseToDetailModel(input: games!)
            view?.showDetail()
        } else {
            view?.showError(error: message!)
        }
    }
}
