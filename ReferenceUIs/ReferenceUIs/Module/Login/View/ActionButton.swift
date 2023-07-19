//
//  ActionButton.swift
//  ReferenceUIs
//
//  Created by Rahul Changaram on 26/06/2023.
//

import SwiftUI

struct ActionButton: View {
    @State var isInProgress: Bool = false
    @State var animating: Bool = false
    var action: () -> (Void)


    var body: some View {
        Button {
            if isInProgress == false {
                action()
                isInProgress = true
            }
        } label: {
            ZStack {
                if isInProgress {
                    HStack(spacing: 8) {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 15,height: 15)
                                .offset(y:animating ? 5 : 0.0)
                        Circle()
                            .fill(Color.white)
                            .frame(width: 15,height: 15)
                            .offset(y:animating ? 10 : 0.0)

                        Circle()
                            .fill(Color.white)
                            .frame(width: 15,height: 15)
                            .offset(y:animating ? 5 : 0.0)
                    }.animation(.linear(duration: 0.6).repeatForever()).onAppear {
                        animating.toggle()
                    }
                } else {
                    Text("Continue").font(.title).fontWeight(.bold)

                }
            }.padding(.horizontal, 40).padding(.vertical, 10)
        }.buttonStyle(GradientButtonStyle())

    }

    func notifyActionComplete() {
        isInProgress = false
    }
}

struct ActionButton_Previews: PreviewProvider {
    static var previews: some View {
        ActionButton {
            
        }.previewLayout(.sizeThatFits)
    }
}
struct GradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(15.0)
    }
}
