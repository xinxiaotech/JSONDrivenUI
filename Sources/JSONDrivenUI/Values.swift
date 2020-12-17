//
//  Values.swift
//
//
//  Created by Enes Karaosman on 1.12.2020.
//

import Foundation
import SwiftUI

internal class Values: Codable {
    var text: String?
    var dateStyle: String?
    var imageUrl: String?
    var systemIconName: String?
    var localImageName: String?
    
    var chartData: [Double]?
}

extension Text.DateStyle {
    static let pick: [String: Text.DateStyle] = [
        "timer": .timer,
        "date": .date,
        "time": .time,
        "offset": .offset,
        "relative": .relative,
    ]
}
