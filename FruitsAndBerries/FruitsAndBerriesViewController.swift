//
//  FruitsAndBerriesViewController.swift
//  iOS-Test
//

import UIKit

protocol FruitsAndBerriesDisplayLogic: AnyObject {
    func display(model: FruitsAndBerriesModels.Load.ViewModel)
    func displayDetails(model: FruitsAndBerriesModels.LoadDetails.ViewModel)
}

class FruitsAndBerriesViewController: UIViewController {
    var interactor: FruitsAndBerriesBusinessLogic?
    var router: FruitsAndBerriesRoutingLogic?
    
    // MARK: - Outlets
    @IBOutlet private var productsTableView: UITableView!
    
    @NibWrapped(LoaderView.self)
    @IBOutlet private var loaderView: UIView!
    
    
    // MARK: - Properties
    private var viewModel: FruitsAndBerriesModels.Load.ViewModel? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.updateUI()
            }
        }
    }
    
    private var selectedProduct: DetailsViewModel?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
        
        setupUI()
        setupTableView()
    }
    
    // MARK: - Common
    private func setupUI() {
        let loadButton = UIBarButtonItem(image: .refreshButton, style: .plain, target: self, action: #selector(load))
        navigationItem.rightBarButtonItem = loadButton
        navigationItem.backButtonDisplayMode = .minimal
    }
    
    private func setupTableView() {
        productsTableView.delegate = self
        productsTableView.dataSource = self
        productsTableView.separatorStyle = .none
        productsTableView.register(.init(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: ProductTableViewCell.cellId)
    }
    
    private func updateUI() {
        productsTableView.reloadData()
        
        guard let viewModel else { return }
        _loaderView.unwrapped.stopAnimation()
        navigationItem.title = viewModel.products.title
    }
    
    @objc private func load() {
        viewModel = nil
        _loaderView.unwrapped.startAnimation()
        interactor?.load(request: .init(item: "random"))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? DetailsViewController, let model = sender as? DetailsViewModel else { return }
        destinationVC.detailsViewModel = model
    }
}

extension FruitsAndBerriesViewController: FruitsAndBerriesDisplayLogic {
    func display(model: FruitsAndBerriesModels.Load.ViewModel) {
        viewModel = model
    }
    
    func displayDetails(model: FruitsAndBerriesModels.LoadDetails.ViewModel) {
        selectedProduct?.description = model.description.text
        
        DispatchQueue.main.async { [weak self] in
            self?.performSegue(withIdentifier: "showDetails", sender: self?.selectedProduct)
        }
    }
}

extension FruitsAndBerriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let animation = AnimationFactory.makeAnimation(duration: 0.5, delay: 0.1)
        let animationManager = AnimationManager(animation: animation)
        animationManager.animate(in: tableView, for: cell, at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let productId = viewModel?.products.items[indexPath.section].id,
        let cell = tableView.cellForRow(at: indexPath) as? ProductTableViewCell
        else { return }
        
        selectedProduct = cell.getDetailsModel()
        interactor?.loadDetails(request: .init(productId: productId))
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FruitsAndBerriesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel else { return 0 }
        
        if viewModel.isProductsListEmpty {
            tableView.showEmptyView()
            return 0
        } else {
            tableView.removeEmptyView()
            return viewModel.products.items.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.cellId, for: indexPath) as? ProductTableViewCell,
              let fruits = viewModel?.products.items
        else { return UITableViewCell() }
        
        let fruit = fruits[indexPath.section]
        let fruitModel = ProductTableViewCell.FruitModel(name: fruit.name, backgroundColor: fruit.color, image: fruit.image)
        cell.configure(with: fruitModel)
        
        return cell
    }
}
