//
//  MovieItem.swift
//
//

import SwiftUI
import Kingfisher

struct MovieItem: View {
    let width: CGFloat
    let imageURL: String
    let title: String
    let year: String
    let onAction: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            if let url = URL(string: imageURL) {
                KFImage(url)
                    .placeholder {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .padding(24)
                    }
                    .resizable()
                    .scaledToFit()
                    .frame(width: width, height: width * 1.5)
                    .cornerRadius(8, corners: [.topLeft, .topRight])
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: width, height: width * 1.5)
            }
            Spacer(minLength: 0)
            HStack {
                VStack(alignment: .leading) {
                    Text(title)
                        .lineLimit(2)
                        Spacer(minLength: 0)
                    Text("Year: \(year)")
                }
                Spacer(minLength: 0)
            }
            .frame(height: 80)
            .padding(.all, 8)

        }
        .background(Color.gray.opacity(0.2))
        .frame(width: width)
        .cornerRadius(8)
        .shadow(radius: 4, x: 0, y: 2)
        .onAppear {
            onAction()
        }
    }
}
