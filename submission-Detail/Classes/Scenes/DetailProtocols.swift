//
//  DetailProtocols.swift
//  submission-Detail
//
//  Created by Ade Resie on 24/12/22.
//

import UIKit
import submission_Core

protocol DetailPresenterToRouterProtocol: AnyObject {
    static func createModule(id: Float) -> UIViewController
}

protocol DetailPresenterToInteractorProtocol: AnyObject {
    var presenter: DetailInteractorToPresenterProtocol? {get set}
    var repository: GameRepositoryProtocol? {get set}
    
    func fetchGameDetail(id: Float)
}

protocol DetailInteractorToPresenterProtocol: AnyObject {
    func gameResult(games: GameResponse?, isSuccess: Bool, message: String?)
}

protocol DetailPresenterToViewProtocol: AnyObject {
    func showDetail()
    func showError(error: String)
}

protocol DetailViewToPresenterProtocol: AnyObject {
    var router: DetailPresenterToRouterProtocol? {get set}
    var interactor: DetailPresenterToInteractorProtocol? {get set}
    var view: DetailPresenterToViewProtocol? {get set}
    var games: GameDetailModel! {get set}
    
    func fetchDetail(id: Float)
}

