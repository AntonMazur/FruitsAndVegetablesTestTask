//
//  FruitsAndBerriesInteractor.swift
//  iOS-Test
//

// Implemented by Interactor
protocol FruitsAndBerriesBusinessLogic {
    // Loads the list of the items and passes Load.Response to Presenter
    func load(request: FruitsAndBerriesModels.Load.Request)
    func loadDetails(request: FruitsAndBerriesModels.LoadDetails.Request)
}

final class FruitsAndBerriesInteractor {
    var loadingTask: Task<Void, Never>?
    var presenter: FruitsAndBerriesPresentationLogic?
}

extension FruitsAndBerriesInteractor: FruitsAndBerriesBusinessLogic {
    func load(request: FruitsAndBerriesModels.Load.Request) {
        loadProducts(for: request.item)
    }
    
    func loadDetails(request: FruitsAndBerriesModels.LoadDetails.Request) {
        loadDescription(for: request.productId)
    }
    
    private func loadProducts(for item: String) {
        loadingTask?.cancel()
        loadingTask = Task {
            var productsModel: Models.ProductsModel
            do {
                guard !Task.isCancelled else { return }
                guard let products = try await NetworkManager.shared.getProducts(for: item) else { return }
                productsModel = products
            } catch {
                productsModel = .init(title: "", items: [])
            }
            guard !Task.isCancelled else { return }
            presenter?.present(response: .init(products: productsModel))
        }
    }
    
    private func loadDescription(for itemId: String) {
        loadingTask?.cancel()
        loadingTask = Task {
            do {
                guard !Task.isCancelled, let descriptionModel = try await NetworkManager.shared.getDescription(itemId) else { return }
                presenter?.presentDescription(response: .init(description: descriptionModel))
            } catch {
                print("An error occured while loading a description! Please, check integration.")
            }
        }
    }
}
