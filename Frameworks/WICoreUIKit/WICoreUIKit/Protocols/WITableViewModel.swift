//
//  WITableViewModel.swift
//  WICoreUIKit
//
//  Created by Michael Artes on 04.12.22.
//

import Combine

public protocol WITableViewModel {
    var updateUI: PassthroughSubject<Bool, Never> { get }
    var sections: [Section] { get }
    func generateSections()
    func setup()
}
