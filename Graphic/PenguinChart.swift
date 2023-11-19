//
//  PenguinChart.swift
//  Graphic
//
//  Created by Эля Корельская on 20.11.2023.
//

import SwiftUI
import Charts

struct PenguinChart: View {
    
    struct TwoDimensionalBinIndex: Hashable {
        let xBinIndex: Int
        let yBinIndex: Int
    }
    typealias BinnedValue = (
        index: TwoDimensionalBinIndex,
        xDataRange: ChartBinRange<Float>,
        yDataRange: ChartBinRange<Float>,
        frequency: Int
    )
    
    var dataset: [PenguinDataPoint]
    
    var bins: [BinnedValue] {
        let binX = NumberBins(data: dataset.map(\.billLength), desiredCount: 30)
        let binY = NumberBins(data: dataset.map(\.billDepth), desiredCount: 30)
        let groupedData = Dictionary(
            grouping: dataset) {
                element in
                TwoDimensionalBinIndex(xBinIndex: binX .index(for: element.billLength), yBinIndex: binY  .index(for: element.billDepth))
            }
        return groupedData.map{
            (key,values) in
            return (
                index: key,
                xDataRange: binX[key.xBinIndex],
                yDataRange: binY[key.yBinIndex],
                frequency: values.count
            )
        }
    }
    
    var body: some View {
       Chart(bins,
             id: \.index) {
           element in
           RectangleMark(x: .value("Bill lenghts", element.xDataRange),
                         y: .value("Bill depths", element.yDataRange),
                         width: .ratio(1),
                         height: .ratio(1))
           .foregroundStyle(by:
                .value("Frequency", element.frequency))
       }.chartXScale(domain:.automatic(includesZero: false))
            .chartYScale(domain:.automatic(includesZero: false))
    }
}

