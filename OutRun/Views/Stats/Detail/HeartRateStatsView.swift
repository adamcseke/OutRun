//
//  HeartRateStatsView.swift
//
//  OutRun
//  Copyright (C) 2020 Tim Fraedrich <timfraedrich@icloud.com>
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

import UIKit
import HealthKit

class HeartRateStatsView: StatsView {

    let avarageHeartRateView = LabelledDataView(title: LS["WorkoutStats.AvarageHeartRate"], measurement: nil)
    let maxHeartRateView = LabelledDataView(title: LS["WorkoutStats.maxHeartRate"], measurement: nil)
    let startDate: Date
    let endDate: Date
    
    init(stats: WorkoutStats) {
        self.startDate = stats.startDate
        self.endDate = stats.endDate

        var statViews = [StatView]()
        statViews.append(contentsOf: [avarageHeartRateView, maxHeartRateView])
        
        super.init(title: "Heart Rate", statViews: statViews)
        
        self.backgroundColor = .backgroundColor
        self.isHidden = true
        self.loadHeartRateData(stats:stats)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func loadHeartRateData(stats: WorkoutStats) {
        HealthQueryManager.getHeartRateSamples(startDate: self.startDate, endDate: self.endDate) { [weak self] samples in
            DispatchQueue.main.async {
                let hasHeartRateData = !samples.isEmpty
                let heartRates = samples.map { sample in
                    sample.heartRate
                }
                let maxHR = heartRates.max()
                let sumHR = heartRates.reduce(0.0, +)
                let hrCount = heartRates.count
                let avgHR = (sumHR / Double(hrCount)).rounded()

                self?.maxHeartRateView.value = NSMeasurement(doubleValue: maxHR ?? 0.0, unit: Unit.init(symbol: "BPM"))
                self?.avarageHeartRateView.value = NSMeasurement(doubleValue: avgHR ?? 0.0, unit: Unit.init(symbol: "BPM"))

                if hasHeartRateData {
                    self?.isHidden = false
                }
            }

        }
    }
}
