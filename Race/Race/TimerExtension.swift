//
//  TimerExtension.swift
//  Race
//
//  Created by Volha Furs on 20.04.22.
//

import UIKit
import Foundation

extension TimeExtension {
    @objc func updateTimer() {
          // 1
    guard let visibleRowsIndexPaths = tableView.indexPathsForVisibleRows else {
            return
          }

          for indexPath in visibleRowsIndexPaths {
            // 2
            if let cell = tableView.cellForRow(at: indexPath) as? TaskTableViewCell {
              cell.updateTime()
            }
          }
        }
    }
    



