//
//  ProductsListViewModel.swift
//  Products List
//
//  Created by yacob kazal on 7/2/2023.
//

import Combine
import Foundation
import CoreData

final class ProductsListViewModel: ObservableObject {
    private var session: URLSessionProtocol
    private let moc: NSManagedObjectContext
    @Published var currentState: APIStatus<Product> = .start
    private var cancelables = Set<AnyCancellable>()
    
    init(withSession session: URLSessionProtocol = URLSession.shared,
         moc: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.session = session
        self.moc = moc
    }
    func fetchProducts() {
        self.currentState = .loading
        APIService(withSession: session).fetchProducts()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Execution Finihsed.")
                case .failure(let error):
                    self.currentState = .failure(error: error.localizedDescription)
                }
            } receiveValue: { [weak self] response in
                guard let self = self else {return}
                for product in response.products{
                    let productObject = ProductObject.findObject(id: product.id, moc: self.moc) ?? ProductObject(context: self.moc)
                    productObject.id = product.id
                    productObject.title = product.title
                    productObject.imageURL = product.imageURL
                    productObject.price = product.price.first?.value ?? 0.0
                }
                do {
                    try self.moc.save()
                    print("saved \(ProductObject.findObjects(moc: self.moc).count)")
                } catch {
                    //TODO:- handle error
                    print("Failed saving")
                }
                self.currentState = .success
            }.store(in: &cancelables)
    }
}
