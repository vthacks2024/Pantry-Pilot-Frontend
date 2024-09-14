

import SwiftUI

struct Recipes: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) { // Lazy column with spacing between items
                ForEach(0..<10, id: \.self) { _ in // Example loop to create multiple cards
                    CustomCardView(
                        width: 350,
                        height: 220,
                        backgroundColor: Color.white,
                        cornerRadius: 20,
                        title: "Shrimp Pasta",
                        caption: "20 min",
                        imageURL: "https://www.eatingwell.com/thmb/LH-H61DAD-1Q3AgeN89BkrWKNEk=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Chicken-piccata-casserole-3x2-167-f44730f489cc4b9493547de1c76a3b93.jpg"
                    )
                }
            }
            .padding()
        }
    }
}
