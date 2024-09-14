import SwiftUI
import UIKit

struct DietaryRestrictions: View {
    @State private var storedImage: UIImage? = nil

    var body: some View {
        VStack {
            if let image = storedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .padding()
            } else {
                Text("No image available")
                    .foregroundColor(.gray)
                    .padding()
            }
        }
        .onAppear {
            loadImageFromDocuments()
        }
        .navigationTitle("Dietary Restrictions")
    }

    // Function to load the image from the app's Documents directory
    private func loadImageFromDocuments() {
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Documents directory not found")
            return
        }
        let fileURL = documentsDirectory.appendingPathComponent("storedImage.jpg")
        
        print("Attempting to load image from: \(fileURL.path)")

        if FileManager.default.fileExists(atPath: fileURL.path) {
            if let imageData = try? Data(contentsOf: fileURL),
               let image = UIImage(data: imageData) {
                storedImage = image
                print("Image successfully loaded")
            } else {
                print("Failed to create UIImage from data")
            }
        } else {
            print("Image file does not exist at path: \(fileURL.path)")
        }
    }
}


