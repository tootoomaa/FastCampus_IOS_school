//
//  Logger.swift
//  CustomLogExample
//
//  Copyright © 2020 giftbot. All rights reserved.
//

import Foundation


class Formatter {
  static let date: DateFormatter = {
    let dateFomatter = DateFormatter()
    dateFomatter.dateFormat = "HH:mm:ss:SSS"
    return dateFomatter
  }()
}

func logger(
  _ contents: Any...,
  header: String = "",
  _ file: String = #file,
  _ function: String = #function,
  _ line: Int = #line
  ) {
  
  let emoji = "!!"
  let timestamp = Formatter.date.string(from: Date())
  
  let fileUrl = URL(fileURLWithPath: file)
  let filename = fileUrl.deletingPathExtension().lastPathComponent

  let header = header.isEmpty ? "" : " [ \(header) ] -"
  let content = contents.reduce("") { $0 + " " + String(describing: $1) }
  
  let combineStr = """
    \(emoji) \(timestamp) / \
    \(filename) \(function) (\(line)) \(emoji)\
    \(header) \(content)
    """
  print(combineStr)
}
