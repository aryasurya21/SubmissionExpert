//
//  Results+Extension.swift
//  Nonton
//
//  Created by IT Division on 05/12/20.
//

import Foundation
import RealmSwift

extension Results {
    public func toCustomObjects<T: Object>(fromType: T.Type) -> [T] {
        var finalResult = [T]()
        for idx in 0 ..< count {
            if let obj = self[idx] as? T {
                finalResult.append(obj)
            }
        }
        return finalResult
    }
}
