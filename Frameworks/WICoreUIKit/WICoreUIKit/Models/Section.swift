//
//  Section.swift
//  WICoreUIKit
//
//  Created by Michael Artes on 04.12.22.
//

public struct Section {
    public let title: String?
    public let footer: String?
    public let cells: [Cell]
    public init(title: String?, footer: String?, cells: [Cell]) {
        self.title = title
        self.footer = footer
        self.cells = cells
    }
}
