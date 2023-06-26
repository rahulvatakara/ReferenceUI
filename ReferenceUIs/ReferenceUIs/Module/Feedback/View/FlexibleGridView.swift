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
        
        for element in data {
            let elementSize = elementsSize[element, default: CGSize(width: availableWidth, height: 1)]
            
            if remainingWidth - (elementSize.width + spacing) >= 0 {
                rows[currentRow].append(element)
            } else {
                currentRow = currentRow + 1
                rows.append([element])
                remainingWidth = availableWidth
            }
            
            remainingWidth = remainingWidth - (elementSize.width + spacing)
        }
        
        return rows
    }
}

struct FlexibleGridView_Previews: PreviewProvider {
    static var keywords: [String] = ["Adventurous","Clean","Good listener","Honest","Homourous","Inspiring","Kind","Knowledgable","Non-jungemental"]
    static var previews: some View {
        GeometryReader { geometryProxy in
            FlexibleGridView(
                         availableWidth: geometryProxy.size.width, data: keywords,
                         spacing: 15,
                         alignment: .leading
                       ) { item in
                         Text(item)
                           .padding(8)
                           .background(
                             RoundedRectangle(cornerRadius: 8)
                               .fill(Color.gray.opacity(0.2))
                            )
                       }
                       .padding(.horizontal, 10)
        }.background(Color.yellow)
         }
    }
