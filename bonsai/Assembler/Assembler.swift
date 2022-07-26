//
//  Assembler.swift
//  bonsai
//
//  Created by antuan.khoanh on 17/07/2022.
//

import Foundation

protocol Assembler {
   associatedtype T
   func assembly() -> T
}
