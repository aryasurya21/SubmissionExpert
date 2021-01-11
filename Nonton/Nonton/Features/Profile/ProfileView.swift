//
//  ProfileView.swift
//  Nonton
//
//  Created by IT Division on 16/11/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            Text("Made by")
                .fontWeight(.bold)
                .font(.title)
            WebImage(url: URL(string: "https://aryasurya.netlify.app/static/media/arya.cfec0762.png")!)
                .resizable()
                .indicator(.activity)
                .frame(width: 300, height: 300, alignment: .center).clipShape(Circle())
                .shadow(radius: 10)
                .overlay(Circle()
                            .stroke(
                                Color.gray,
                                lineWidth: 5
                            )
                ).listRowInsets(
                    EdgeInsets(
                        top: 10, leading: 0, bottom: 10, trailing: 0
                    )
                )
            Text("Arya S")
                .font(.largeTitle)
                .fontWeight(.bold)

        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
