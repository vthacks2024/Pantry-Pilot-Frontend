import SwiftUI

struct Recipes: View {
    let recipes = mockRecipes // Use your mock data list

    @Binding var selectedRecipe: Recipe? // Binding to track the selected recipe

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) { // Lazy column with spacing between items
                ForEach(recipes) { recipe in
                    NavigationLink(
                        destination: RecipeDetailView(recipeName: recipe.title, imageURL: recipe.imageURL)
                    ) {
                        CustomCardView(
                            width: 350,
                            height: 220,
                            backgroundColor: Color.white,
                            cornerRadius: 20,
                            title: recipe.title,   // Use the title from mock data
                            caption: recipe.caption, // Use the caption from mock data
                            imageURL: recipe.imageURL // Use the image URL from mock data
                        )
                    }
                    .buttonStyle(PlainButtonStyle()) // Removes default button styling
                }
            }
            .padding()
        }
    }
}



// Define a data model for Recipe
struct Recipe: Identifiable {
    let id = UUID() // Unique identifier for each recipe
    let title: String
    let caption: String
    let imageURL: String
}

// Create a mock data list of recipes with realistic names, captions as cooking times, and real image URLs
let mockRecipes: [Recipe] = [
    Recipe(
        title: "Chicken Alfredo Pasta",
        caption: "30 min",
        imageURL: "https://bellyfull.net/wp-content/uploads/2021/02/Chicken-Alfredo-blog-3.jpg"
    ),
    Recipe(
        title: "Grilled Salmon with Asparagus",
        caption: "20 min",
        imageURL: "https://www.thecookierookie.com/wp-content/uploads/2023/05/featured-grilled-salmon-recipe.jpg"
    ),
    Recipe(
        title: "Vegetable Stir Fry",
        caption: "15 min",
        imageURL: "https://www.dinneratthezoo.com/wp-content/uploads/2017/03/vegetable-stir-fry-3.jpg"
    ),
    Recipe(
        title: "Beef Tacos",
        caption: "25 min",
        imageURL: "https://www.cookingclassy.com/wp-content/uploads/2019/07/beef-tacos-1.jpg"
    ),
    Recipe(
        title: "Margherita Pizza",
        caption: "40 min",
        imageURL: "https://www.acouplecooks.com/wp-content/uploads/2020/06/Margherita-Pizza-011.jpg"
    ),
    Recipe(
        title: "Shrimp Scampi",
        caption: "20 min",
        imageURL: "https://www.simplyrecipes.com/thmb/jU7E48yLAc3m1oXrfEPzpb4o2pU=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Simply-Recipes-Shrimp-Scampi-LEAD-1-a16514eb27f94fb6ae151c77132aa0e7.jpg"
    ),
    Recipe(
        title: "Mushroom Risotto",
        caption: "35 min",
        imageURL: "https://www.recipetineats.com/wp-content/uploads/2019/03/Mushroom-Risotto_8-SQ.jpg"
    ),
    Recipe(
        title: "Chicken Caesar Salad",
        caption: "15 min",
        imageURL: "https://www.simplyrecipes.com/thmb/qIc2iAcm6hNaf8q-tou2yIEoFKw=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Simply-Recipes-Chicken-Caesar-Salad-LEAD-2a-b96b03f7981d48c1b912403f08d5a0eb.jpg"
    )
]

