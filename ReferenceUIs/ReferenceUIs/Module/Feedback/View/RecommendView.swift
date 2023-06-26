//
//  RecommendView.swift
//  ReferenceUIs
//
//  Created by Rahul Changaram on 23/06/2023.
//

import SwiftUI

struct RecommendView: View {
    var recommeded:  Binding<Bool?>
    var body: some View {
        HStack(spacing:50) {
            Button {
                recommeded.wrappedValue = true
            } label: {
                HStack(spacing:10) {
                    Image(systemName:"hand.thumbsup.fill")
                        .resizable().frame(width: 50, height: 50)
                        .foregroundColor(
                            (recommeded.wrappedValue ?? false) ? Color("feedbackGreen"):
                            Color("feedbackGray")
                        )
                    Text("Yes")
                        .offset(y:10).foregroundColor(Color("feedbackTitle"))
                }
            }
            Button {
                recommeded.wrappedValue = false
            } label: {
                HStack(spacing:10) {
                    Image(systemName:"hand.thumbsdown.fill")
                        .resizable().frame(width: 50, height: 50)
                        .foregroundColor(
                            (recommeded.wrappedValue ?? true) ? Color("feedbackGray"):
                            Color("feedbackGreen")
                        )
                    Text("No")
                        .offset(y:10).foregroundColor(Color("feedbackTitle"))
                }
            }
        }
    }
}

struct RecommendView_Previews: PreviewProvider {
     @State static var feedback: Bool? = false

    static var previews: some View {
        RecommendView(recommeded: $feedback)
    }
}
