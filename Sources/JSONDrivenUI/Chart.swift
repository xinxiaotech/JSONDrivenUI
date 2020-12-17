//
//  Chart.swift
//
//
//  Created by Makito on 2020/12/16.
//

import Foundation
import SwiftUI
import SwiftUICharts

struct Chart: View {
    enum Style: String {
        case line, bar
    }

    let style: Style
    let data: [Double]

    private let internalStyle: ChartStyle

    init(style: Style?, data: [Double]?, backgroundColor: Color?, foregroundColor: Color?) {
        self.style = style ?? .line
        self.data = data ?? []
        self.internalStyle = ChartStyle(backgroundColor: backgroundColor ?? Color.white.opacity(0),
                                        foregroundColor: [ColorGradient(foregroundColor ?? Color.black, foregroundColor ?? Color.black)])
    }

    var body: some View {
        switch style {
        case .line:
            LineChart().data(data).chartStyle(internalStyle).allowsHitTesting(false)
        case .bar:
            BarChart().data(data).chartStyle(internalStyle).allowsHitTesting(false)
        default:
            EmptyView()
        }
    }
}
