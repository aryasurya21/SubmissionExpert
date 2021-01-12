//
//  Router.swift
//  NCore
//
//  Created by IT Division on 12/01/21.
//

import Foundation
import SwiftUI

public protocol Router {
    associatedtype Request
    associatedtype Destination: View
    func navigate(with request: Request?) -> Destination
}
