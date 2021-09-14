//
//  CommonError.swift
//  BHomeWork
//
//  Created by Oh june Kwon on 2021/09/14.
//

import Foundation

struct CommonError: Codable, Error {
  let status: Int
  let message: String
  var resCode: String?
  
  enum CodingKeys: String, CodingKey {
    case status
    case message
  }

  init(message: String, resCode: String? = nil) {
    self.message = message
    self.status = 9999
    self.resCode = resCode
  }

  init(message: String, status: Int = 99999, resCode: String? = nil) {
    self.message = message
    self.status = status
    self.resCode = resCode
  }
}
