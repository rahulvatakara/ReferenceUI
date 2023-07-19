//
//  FlexibleGridView.swift
//  ReferenceUIs
//
//  Created by Rahul Changaram on 24/06/2023.
//

import SwiftUI

struct FlexibleGridView<Data: Collection, Content: View>: View where Data.Element: Hashable {
    let availableWidth: CGFloat
    let data: Data
    let spacing: CGFloat
    let alignment: HorizontalAlignment
    let content: (Data.Element) -> Content
    @State var elementsSize: [Data.Element: CGSize] = [:]
    
    var body : some View {
        VStack(alignment: alignment, spacing: spacing) {
            ForEach(computeRows(), id: \.self) { rowElements in
                HStack(spacing: spacing) {
                    ForEach(rowElements, id: \.self) { element in
                        content(element)
                            .fixedSize()
                            .readSize { size in
                                elementsSize[element] = size
                            }
                    }
                }
            }
        }
    }

    func computeRows() -> [[Data.Element]] {
        var rows: [[Data.Element]] = [[]]
        var currentRow = 0
        var remainingWidth = availableWidth
        for item in data {
            let size = elementsSize[item, default: CGSize(width: availableWidth - 1, height: 1)]
            if (remainingWidth - size.width - spacing) > 0 {
                print("\(currentRow), \(remainingWidth) \(size.width)")
                rows[currentRow].append(item)
            } else {
                print(":::\(currentRow)")
                currentRow += 1
                rows.append([item])
                remainingWidth = availableWidth
            }
            remainingWidth = remainingWidth - spacing - size.width
        }
        print(rows)
        return rows
    }
}

struct FlexibleGridView_Previews: PreviewProvider {
    static var keywords: [String] = ["Adventurous","Clean","Good listener","Honest","Homourous","Inspiring","Kind","Knowledgable","Non-jungemental"]
    static var previews: some View {
        GeometryReader { geometryProxy in
            FlexibleGridView(
                         availableWidth: geometryProxy.size.width, data: keywords,
                         spacing: 0,
                         alignment: .center
                       ) { item in
                         Text(item)
                           .padding(8)
                           .background(
                             RoundedRectangle(cornerRadius: 8)
                               .fill(Color.gray.opacity(0.2))
                            )
                       }
                       .padding(.horizontal, 10)
        }.background(Color.white)
         }
    }
