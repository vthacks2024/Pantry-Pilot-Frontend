import SwiftUI
import UIKit

struct AddImage: View {
    @State private var isImagePickerPresented = false // Manage the presentation of the image picker
    @State private var selectedImage: UIImage? = nil // Store the selected image
    @State private var showImageSourceOptions = false // Manage the display of the action sheet

    var body: some View {
        VStack {
            Text("Welcome, User")
                .font(.largeTitle)
                .padding()

            if let selectedImage = selectedImage { // Display the selected image or placeholder text
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .padding()
            } else {
                Text("No image selected")
                    .foregroundColor(.gray)
                    .padding()
            }
            
            Button(action: {
                showImageSourceOptions = true // Show action sheet for image source options
            }) {
                HStack {
                    Image(systemName: "photo.on.rectangle.angled")
                        .font(.title)
                    Text("Add Image")
                        .font(.headline)
                }
            }
            .padding()
        }
        .actionSheet(isPresented: $showImageSourceOptions) { // Action sheet to choose image source
            ActionSheet(
                title: Text("Choose Image Source"),
                message: Text("Select an image from your photo library or take a new one."),
                buttons: [
                    .default(Text("Camera")) {
                        isImagePickerPresented = true // Present image picker for camera
                    },
                    .default(Text("Photo Library")) {
                        isImagePickerPresented = true // Present image picker for photo library
                    },
                    .cancel()
                ]
            )
        }
        .sheet(isPresented: $isImagePickerPresented) { // Present the image picker sheet
            ImagePicker(selectedImage: $selectedImage, sourceType: .photoLibrary)
        }
        .onChange(of: selectedImage) { newImage in
            if let image = newImage {
                saveImageToDocuments(image)
            }
        }
    }

    // Function to save the selected image to the app's Documents directory
    private func saveImageToDocuments(_ image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 1.0) else { return }
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = documentsDirectory.appendingPathComponent("storedImage.jpg")
        
        do {
            try imageData.write(to: fileURL)
            print("Image saved to \(fileURL.path)")
        } catch {
            print("Error saving image: \(error)")
        }
    }
}

// Custom Image Picker using UIImagePickerController
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage? // Bind the selected image
    var sourceType: UIImagePickerController.SourceType // Source type (camera or photo library)

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image // Update the selected image
            }
            picker.dismiss(animated: true)
        }
    }
}

