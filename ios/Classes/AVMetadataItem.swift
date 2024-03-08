//
//  AVMetadataItem.swift
//  media_data_extractor
//
//  Created by LeeWei on 2024/3/5.
//

import Foundation
import AVFoundation

extension AVMetadataItem {
    func keyString() -> String {
        if let key = self.key as? String {
          return key
        }
        if let numberValue = self.key as? NSNumber {
            let value = numberValue.uint32Value
          
            // 根据 UInt32 值获取四字符编码（FourCC）字符串
            let string = String(bytes: [
              UInt8((value >> 24) & 0xFF),
              UInt8((value >> 16) & 0xFF),
              UInt8((value >> 8) & 0xFF),
              UInt8(value & 0xFF)
            ], encoding: .ascii)

            return string ?? "<<unknown>>"
        }
        return "<<unknown>>"
      }
}
