//
//  FruitsAndBerriesPresenter.swift
//  iOS-Test
//

// Implemented by View layer (ViewControllers)
protocol FruitsAndBerriesPresentationLogic {
    func present(response: FruitsAndBerriesModels.Load.Response)
    func presentDescription(response: FruitsAndBerriesModels.LoadDetails.Response)
}

final class FruitsAndBerriesPresenter {
    weak var view: FruitsAndBerriesDisplayLogic?
}

extension FruitsAndBerriesPresenter: FruitsAndBerriesPresentationLogic {
    // Transforms Load.Response into ViewModel to be displayed by the ViewController
    func present(response: FruitsAndBerriesModels.Load.Response) {
        view?.display(model: .init(products: response.products))
    }
    
    func presentDescription(response: FruitsAndBerriesModels.LoadDetails.Response) {
        view?.displayDetails(model: .init(description: response.description))
    }
}
