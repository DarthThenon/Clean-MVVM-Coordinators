//
//  Coordinator.swift
//  CoordinatorsTest
//
//  Created by Dmytro Yurchenko on 01.02.2022.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController? { get }
    var childs: [Coordinator] { get set }
    var parent: WeakRefCoordinatorWrapper? { get set }
    
    func start()
    func removeFromParent()
    func removeFromParent(animated: Bool)
    func removeChild(_ child: Coordinator)
    func addChild(_ child: Coordinator, animated: Bool)
    func addChild(_ child: Coordinator)
}

extension Coordinator {
    func removeFromParent() {
        removeFromParent(animated: true)
    }
    
    func removeFromParent(animated: Bool) {
        parent?.weakReference?.removeChild(self)
        
        navigationController?.dismiss(animated: animated)
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
        child.navigationController.flatMap {
            navigationController?.present($0, animated: animated)
        }
    }
}
