//
//  FruitsAndBerriesRouter.swift
//  iOS-Test
//

import UIKit

protocol FruitsAndBerriesRoutingLogic {
    
}

final class FruitsAndBerriesRouter {
    weak var controller: FruitsAndBerriesViewController?
}

extension FruitsAndBerriesRouter: FruitsAndBerriesRoutingLogic {
    
}

extension FruitsAndBerriesRouter {
    static func createModule() -> FruitsAndBerriesViewController {
        let controller = UIStoryboard(name: "FruitsAndBerries", bundle: nil)
            .instantiateViewController(withIdentifier: "FruitsAndBerriesViewController") as! FruitsAndBerriesViewController
        let interactor = FruitsAndBerriesInteractor()
        let presenter = FruitsAndBerriesPresenter()
        let router = FruitsAndBerriesRouter()
        
        controller.interactor = interactor
        controller.router = router
        interactor.presenter = presenter
        presenter.view = controller
        return controller
    }
}
