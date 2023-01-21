//
//  Montserrat.swift
//  TaskPlanner
//
//  Created by Berkay Disli on 21.01.2023.
//

import SwiftUI

enum Montserrat {
    case light, regular, medium,bold
    
    var weight: Font.Weight {
        switch self {
        case .light:
            return .light
        case .regular:
            return .regular
        case .medium:
            return .medium
        case .bold:
            return .bold
        }
    }
}

extension View {
    func montserrat(_ size: CGFloat, weight: Montserrat) -> some View {
        self
            .font(.custom("Montserrat", size: size))
            .fontWeight(weight.weight)
    }
}
