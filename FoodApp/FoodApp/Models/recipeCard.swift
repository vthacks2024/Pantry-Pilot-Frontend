//
//  recipeCard.swift
//  FoodApp
//
//  Created by vthacks on 9/14/24.
//

import Foundation

import SwiftUI

struct Recipe: Identifiable, Decodable {
    let id: Int32
    let name: String
    let ingredients: [String]
    let instructions: String
}

struct RecipeCard: View {
    let recipe: Recipe

    var body: some View {
        VStack(alignment: .leading) {
            Text(recipe.name)
                .font(.headline)
            Text("Ingredients:")
                .font(.subheadline)
                .bold()
            ForEach(recipe.ingredients, id: \.self) { ingredient in
                Text("• \(ingredient)")
            }
            Text("Instructions:")
                .font(.subheadline)
                .bold()
            Text(recipe.instructions)
                .font(.body)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

