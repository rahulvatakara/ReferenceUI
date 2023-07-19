//
//  Test.swift
//  ReferenceUIs
//
//  Created by Rahul Changaram on 27/06/2023.
//

import SwiftUI

struct Test: View {
    @State var sizes: [String: CGSize] = [:]
    var keywords: [String] = ["Adventuroushhhhhhhhjjjjjjjj","Clean","Good listener","Honest","Homourous","Inspiring","Kind","Knowledgable","Non-jungemental", "Spontanious", "Talkitive", "Thoughtful", "Trustworthy"]
    let columns = [
        GridItem(.adaptive(minimum: 100), spacing: 0, alignment: .center)
    ]
    var availableWidth = 0
    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(keywords, id: \.self) { item in
                Text(item).fixedSize()
                    .padding(12)
                    .foregroundColor(.black)
                    .background(
                        Capsule()
                            .fill(.green)
                    )
            }
        }
    }
}
struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
