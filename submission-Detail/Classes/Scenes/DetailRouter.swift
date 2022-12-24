//
//  DetailRouter.swift
//  submission-Detail
//
//  Created by Ade Resie on 24/12/22.
//

import UIKit
import submission_Core

public class DetailRouter: DetailPresenterToRouterProtocol {
    public static func createModule(id: Float) -> UIViewController {
        let view = DetailViewController()
        view.id = id
        let presenter = DetailPresenter()
        let router = DetailRouter()
        let interactor = DetailInteractor()
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        interactor.repository = Injection.getInstance()
        return view
    }
}
