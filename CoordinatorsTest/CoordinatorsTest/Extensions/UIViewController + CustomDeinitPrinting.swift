//
//  UIViewController + CustomDeinitPrinting.swift
//  CoordinatorsTest
//
//  Created by Dmitriy Yurchenko on 25.02.2023.
//

import UIKit

extension UIViewController {
    func printDeinit() {
#if DEBUG
        print("♻️ \(String(describing: type(of: self))) has been deinitialized")
#endif
    }
}
