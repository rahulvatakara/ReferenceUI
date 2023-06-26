//
//  RatingView.swift
//  ReferenceUIs
//
//  Created by Rahul Changaram on 23/06/2023.
//

import SwiftUI

struct RatingView: View {
    var rating:  Binding<Int>
    var body: some View {
        GeometryReader { reader in
            HStack(spacing: 5) {
                ForEach(0 ..< 5) { item in
                    Button {
                        rating.wrappedValue = item + 1
                    } label: {
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: reader.size.width * 0.2, height: reader.size.width * 0.2)
                            .foregroundColor(item < rating.wrappedValue ? .yellow: .gray)
                    }
                }
            }.animation(.easeIn, value: rating.wrappedValue)
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    @State static var rating: Int = 0
    static var previews: some View {
        RatingView(rating: $rating).frame(width: 200, height: 200)
    }
}
