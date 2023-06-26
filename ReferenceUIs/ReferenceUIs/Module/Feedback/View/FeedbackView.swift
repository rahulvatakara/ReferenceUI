//
//  FeedbackView.swift
//  ReferenceUIs
//
//  Created by Rahul Changaram on 22/06/2023.
//

import SwiftUI

struct FeedbackView: View {
    @State var safetyRating: Int = 0
    @State var communicationRating: Int = 0
    @State var isRecommeted: Bool?
    @State var selectedKeywords: [String] = []
    @State var reviewText: String = ""
    
    var keywords: [String] = ["Adventurous","Clean","Good listener","Honest","Homourous","Inspiring","Kind","Knowledgable","Non-jungemental", "Spontanious", "Talkitive", "Thoughtful", "Trustworthy"]

    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10) {
                    // MARK: - Safety Section
                    section(title: Constants.feedback.sectionTitleOne,
                            subTitle: Constants.feedback.sectionDescriptionOne) {
                        AnyView(RatingView(rating: $safetyRating)
                            .frame(width: 250, height: 70))
                    }
                    divider()

                    // MARK: - Communication Section
                    section(title: Constants.feedback.sectionTitleTwo,
                            subTitle: Constants.feedback.sectionDescriptionTwo) {
                        AnyView(RatingView(rating: $communicationRating)
                            .frame(width: 250, height: 70))
                    }
                    divider()
    
                    // MARK: - Recommend Section
                    section(title: Constants.feedback.sectionTitleThree,
                            subTitle: Constants.feedback.sectionDescriptionThree) {
                        AnyView(RecommendView(recommeded: $isRecommeted).padding(.top, 10))
                    }
                    divider()

                    // MARK: - Praise Section
                    section(title: Constants.feedback.sectionTitleFour,
                            subTitle: Constants.feedback.sectionDescriptionFour) {
                        AnyView(GeometryReader { geometryProxy in
                            FlexibleGridView(
                                availableWidth: geometryProxy.size.width, data: keywords,
                                spacing: 15,
                                alignment: .leading
                            ) { item in
                                Button {
                                    if selectedKeywords.contains(item) {
                                        selectedKeywords.removeAll {$0 == item}
                                    } else {
                                        selectedKeywords.append(item)
                                    }
                                } label: {
                                    Text(item)
                                        .padding(12)
                                        .foregroundColor(.black)
                                        .background(
                                            Capsule()
                                                .fill(gridColor(keyword: item))
                                        )
                                }
                            }
                        }.frame(height: 300).padding(.horizontal, -5))
                    }
                    divider()

                    // MARK: - Review Section
                    section(title: Constants.feedback.sectionTitleFive,
                            subTitle: Constants.feedback.sectionDescriptionFive) {
                        AnyView(TextEditor(text: $reviewText)
                            .font(.body)
                            .foregroundStyle(.secondary).frame(height: 170)
                            .cornerRadius(12)
                            .border(Color("feedbackTitle").opacity(0.2), width:1))
                    }

                    // MARK: - Action Button
                    button(title: Constants.feedback.buttonTitle){
                    }
                }
            }.frame(maxWidth: .infinity, alignment: .leading)
                .navigationBarTitle(Constants.feedback.title, displayMode: .large)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            
                        } label: {
                            Image(systemName: "xmark").font(.title3).fontWeight(.medium).foregroundColor(.black)
                        }
                    }
                }
        }
    }

    @ViewBuilder
    func section(title: String, subTitle: String, content: @escaping () -> (AnyView)) -> AnyView {
        AnyView(VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.title2)
                .fontWeight(.medium).padding(.horizontal, 20)
            Text(subTitle)
                .font(.subheadline)
                .foregroundColor(.gray).padding(.horizontal, 20)
            content().padding(.horizontal, 20)
        }.padding(.top, 20))
    }

    func divider() -> some View {
        Divider().padding(.horizontal).foregroundColor(Color("feedbackTitle"))
    }

    @ViewBuilder
    func button(title: String, action: @escaping () -> (Void)) -> AnyView {
        AnyView(Button {
            action()
        } label: {
            HStack {
                Spacer()
                Text(title)
                    .font(.title2)
                    .foregroundColor(Color("feedbackTitle"))
                Spacer()
            }.padding()
                .background(Color("feedbackGreen").cornerRadius(8))
        }.padding(.horizontal, 20).padding(.top, 20))
    }
    func gridColor(keyword: String) -> Color {
        selectedKeywords.contains(keyword) ? Color("feedbackGreen"): Color("feedbackGray")
    }
}

struct FeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackView()
    }
}
