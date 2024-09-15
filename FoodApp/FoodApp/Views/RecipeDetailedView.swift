import SwiftUI

struct RecipeDetailView: View {
    var recipeName: String // The name of the recipe to display
    var imageURL: String // The URL of the image to display

    var body: some View {
        VStack {
            // Add padding at the top of the image
            Spacer().frame(height: 20) // Adjust the padding height as needed

            // Display the recipe image
            AsyncImage(url: URL(string: imageURL)) { phase in
                switch phase {
                case .empty:
                    // Placeholder while the image is loading
                    Color.gray.opacity(0.1)
                        .frame(height: UIScreen.main.bounds.height / 3) // Fixed height for 1/3 of the screen
                        .cornerRadius(20) // Apply rounded corners
                        .padding(.horizontal) // Add horizontal padding
                case .success(let image):
                    // Display the loaded image
                    image
                        .resizable()
                        .scaledToFill() // Ensure the image fills the space
                        .frame(height: UIScreen.main.bounds.height / 3) // Fixed height for 1/3 of the screen
                        .clipped() // Clip the image to maintain the aspect ratio
                        .cornerRadius(20) // Apply rounded corners
                        .padding(.horizontal) // Add horizontal padding
                case .failure:
                    // Display an error placeholder if the image failed to load
                    Color.red
                        .frame(height: UIScreen.main.bounds.height / 3) // Fixed height for 1/3 of the screen
                        .overlay(
                            Text("Failed to load image")
                                .foregroundColor(.white)
                        )
                        .cornerRadius(20) // Apply rounded corners
                        .padding(.horizontal) // Add horizontal padding
                @unknown default:
                    EmptyView()
                }
            }
            .frame(height: UIScreen.main.bounds.height / 3) // Fixed height for 1/3 of the screen
            
            // Display the recipe name
            Text(recipeName)
                .font(.largeTitle)
                .padding()

            Spacer() // Add some spacing to center the text
        }
        .background(Color.white) // Set background to white to avoid invisible content
    }
}

