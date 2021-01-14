//
//  ErrorView.swift
//  Nonton
//
//  Created by IT Division on 16/11/20.
//

import SwiftUI

struct ErrorView: View {
    var errorMessage: String

    var body: some View {
        VStack {
            Text("Sorry, Something went wrong :(")
            Text(errorMessage)
                .font(.title)
                .fontWeight(.bold)
            Image("errorLogo")
                .resizable()
                .frame(width: 150, height: 150, alignment: .center/*@END_MENU_TOKEN@*/)

        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(errorMessage: "HAHAHA")
    }
}
