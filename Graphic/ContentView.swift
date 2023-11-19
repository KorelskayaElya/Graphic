//
//  ContentView.swift
//  Graphic
//
//  Created by Эля Корельская on 20.11.2023.
//

import SwiftUI
import Charts

struct ContentView: View {
    
    //    struct MounthlySunshineHoursValue {
    //        var city: String
    //        var hours: Double
    //        var mounth: Int
    //
    //    }
    //
    //    var data: [MounthlySunshineHoursValue] {
    //        [MounthlySunshineHoursValue(city: "Moscow", hours: 200, mounth: 1),
    //         MounthlySunshineHoursValue(city: "Moscow", hours: 321, mounth: 2),
    //        MounthlySunshineHoursValue(city: "Saint-Petersburg", hours: 57, mounth: 1),
    //        MounthlySunshineHoursValue(city: "Saint-Petersburg", hours: 78, mounth: 2)
    //         ]
    //    }
    //
    //        Chart(data, id: \.city) {
    //            element in
    //            LineMark(x: .value("Month", element.mounth),
    //                     y: .value("Hours",element.hours),
    //                     series: .value("City",element.city)).foregroundStyle(by: .value("City", element.city))
    //
    //        }.chartXScale(domain: .automatic(includesZero: false)).font(.system(.caption)).chartLegend(.visible)
    @State
    var dataset = [PenguinDataPoint]()
    @State
    var error: Error?
    
    var body: some View {
        
        PenguinChart(dataset: dataset).task {
            do {
                self.dataset = try await PenguinDataPoint.load()
                //print(self.dataset)
            } catch {
                print("Error loading data:", error)
                self.error = error
            }
        }
    }
}

#Preview {
    ContentView()
}
