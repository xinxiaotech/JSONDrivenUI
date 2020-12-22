//
//  Chart.swift
//
//
//  Created by Makito on 2020/12/16.
//

import Charts
import Foundation
import SwiftUI
import SwiftUICharts
import UIKit

struct Chart: View {
    enum Style: String {
        case line, bar
    }

    private let internalSwiftUIChartsStyle: ChartStyle

    private let style: Style
    private let data: [Double]
    private let foregroundColor: Color
    private let fillGradient: CGGradient

    init(style: Style?, data: [Double]?, foregroundColor: Color?) {
        self.style = style ?? .line
        self.data = data ?? []
        self.foregroundColor = foregroundColor ?? .blue

        self.internalSwiftUIChartsStyle = ChartStyle(
            backgroundColor: Color.white.opacity(0),
            foregroundColor: [ColorGradient(foregroundColor ?? Color.black, foregroundColor ?? Color.black)])

        let (r, g, b, o) = self.foregroundColor.components
        let gradientStart = UIColor(red: r, green: g, blue: b, alpha: o * 0.8)
        let gradientStop = UIColor(red: r, green: g, blue: b, alpha: o * 0.8 * 0.5)
        let gradientColors = [gradientStart.cgColor, gradientStop.cgColor]
        self.fillGradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
    }

    var body: some View {
        switch style {
        case .line:
            UILineChartView(data: Binding.constant(data), fillGradient: Binding.constant(fillGradient))
        case .bar:
            BarChart()
                .data(data)
                .chartStyle(internalSwiftUIChartsStyle)
                .allowsHitTesting(false)
        }
    }
}

struct UILineChartView: UIViewRepresentable {
    @Binding var data: [Double]
    @Binding var fillGradient: CGGradient

    func makeUIView(context: Context) -> LineChartView {
        let chartView = LineChartView()

        chartView.legend.enabled = false

        [chartView.leftAxis, chartView.rightAxis].forEach { axis in
            axis.drawLabelsEnabled = false
            axis.drawAxisLineEnabled = false
            axis.drawZeroLineEnabled = false
            axis.drawGridLinesEnabled = false
            axis.drawTopYLabelEntryEnabled = false
            axis.drawLimitLinesBehindDataEnabled = false
        }

        chartView.xAxis.drawLabelsEnabled = false
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.drawAxisLineEnabled = false
        chartView.xAxis.drawLimitLinesBehindDataEnabled = false
        chartView.xAxis.drawGridLinesBehindDataEnabled = false

        chartView.drawMarkers = false
        chartView.drawBordersEnabled = false
        chartView.drawGridBackgroundEnabled = false

        chartView.chartDescription?.enabled = false
        chartView.dragEnabled = false
        chartView.setScaleEnabled(false)
        chartView.pinchZoomEnabled = false

        return chartView
    }

    func updateUIView(_ chartView: LineChartView, context: Context) {
        let entries = (0 ..< data.count).map { (i) -> ChartDataEntry in
            ChartDataEntry(x: Double(i), y: data[i])
        }

        let dataSet = LineChartDataSet(entries: entries)
        dataSet.drawValuesEnabled = false
        dataSet.drawFilledEnabled = true
        dataSet.drawVerticalHighlightIndicatorEnabled = false
        dataSet.drawHorizontalHighlightIndicatorEnabled = false
        dataSet.lineDashLengths = nil
        dataSet.highlightLineDashLengths = nil
        dataSet.drawCirclesEnabled = false
        dataSet.lineWidth = 2

        dataSet.fill = Fill(linearGradient: fillGradient, angle: 90)

        chartView.data = LineChartData(dataSet: dataSet)
    }
}
