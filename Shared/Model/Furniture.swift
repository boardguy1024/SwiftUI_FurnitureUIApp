//
//  Furniture.swift
//  SwiftUI_FurnitureUIApp
//
//  Created by park kyung seok on 2022/07/10.
//

import SwiftUI

struct Furniture: Identifiable {
    var id = UUID().uuidString
    var name: String
    var description: String
    var price: String
    var image: String
}
