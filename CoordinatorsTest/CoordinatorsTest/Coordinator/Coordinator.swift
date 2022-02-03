//
//  Coordinator.swift
//  CoordinatorsTest
//
//  Created by Dmytro Yurchenko on 01.02.2022.
//

import UIKit

final class WeakRefCoordinatorWrapper {
    private(set) weak var weakReference: Coordinator?
    
    init(coordinator: Coordinator) {
        self.weakReference = coordinator
    }
}

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get }
    var childs: [Coordinator] { get set }
    var parent: WeakRefCoordinatorWrapper? { get set }
    
    func start()
    func removeFromParent()
    func removeChild(_ child: Coordinator)
    func addChild(_ child: Coordinator, animated: Bool)
    func addChild(_ child: Coordinator)
}

extension Coordinator {
    func removeFromParent() {
        parent?.weakReference?.removeChild(self)
    }
    
    func removeChild(_ child: Coordinator) {
        guard !childs.isEmpty else { return }
        
        guard let index = childs.firstIndex(where: { $0 === child })
        else { return }
        
        childs.remove(at: index)
    }
    
    func addChild(_ child: Coordinator) {
        addChild(child, animated: true)
    }
    
    func addChild(_ child: Coordinator, animated: Bool) {
        childs.append(child)
        
        child.parent = WeakRefCoordinatorWrapper(coordinator: self)
        
        navigationController.present(child.navigationController, animated: animated)
    }
}
