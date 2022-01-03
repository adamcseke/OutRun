//
//  [FILENAME]
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
import Charts

class HeartRateStatsView: StatsView {
    
    init(stats: WorkoutStats) {
        
        var statViews = [StatView]()
        
        let avarageHeartRateView = LabelledDataView(title: LS["WorkoutStats.AvarageHeartRate"], measurement: stats.avarageHeartRate)
        let maxHeartRateView = LabelledDataView(title: LS["WorkoutStats.maxHeartRate"], measurement: stats.maxHeartRate)
        
        if stats.distance.doubleValue == 0 {
            statViews.append(contentsOf: [avarageHeartRateView, maxHeartRateView])
        } else {
            statViews.append(contentsOf: [avarageHeartRateView, maxHeartRateView])
        }
        
        super.init(title: "Heart Rate", statViews: statViews)
        
        self.backgroundColor = .backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
