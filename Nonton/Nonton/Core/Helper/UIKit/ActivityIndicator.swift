//
//  ActivityIndicator.swift
//  Nonton
//
//  Created by IT Division on 16/11/20.
//

import Foundation
import SwiftUI

struct ActivityIndicator: UIViewRepresentable {

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.color = .black
        return activityIndicator
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        uiView.startAnimating()
    }
}
