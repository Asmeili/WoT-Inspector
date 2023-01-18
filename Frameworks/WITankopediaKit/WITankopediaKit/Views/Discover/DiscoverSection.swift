//
//  DiscoverSection.swift
//  WITankopediaKit
//
//  Created by Michael Artes on 06.12.22.
//

enum DiscoverSectionType {
    case chips
    case results
}

struct DiscoverSection: Hashable {
    let type: DiscoverSectionType
    let items: [DiscoverItem]
}
