

import SwiftUI

struct Recipes: View {
    var body: some View {
        Text("Welcome, User")
        CustomCardView(
                    width: 350,
                    height: 220,
                    backgroundColor: Color.white,
                    cornerRadius: 20,
                    text: "Custom Card",
                    imageURL: "https://www.eatingwell.com/thmb/LH-H61DAD-1Q3AgeN89BkrWKNEk=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Chicken-piccata-casserole-3x2-167-f44730f489cc4b9493547de1c76a3b93.jpg"
                )
    }
}
