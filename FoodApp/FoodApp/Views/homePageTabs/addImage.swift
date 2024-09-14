import SwiftUI
import UIKit

struct AddImage: View {
    @State private var isImagePickerPresented = false
    @State private var selectedImage: UIImage? = nil
    @State private var showImageSourceOptions = false

    var body: some View {
        VStack {
            if let selectedImage = selectedImage {
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
                showImageSourceOptions = true
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
        .actionSheet(isPresented: $showImageSourceOptions) {
            ActionSheet(
                title: Text("Choose Image Source"),
                message: Text("Select an image from your photo library or take a new one."),
                buttons: [
                    .default(Text("Camera")) {
                        isImagePickerPresented = true
                    },
                    .default(Text("Photo Library")) {
                        isImagePickerPresented = true
                    },
                    .cancel()
                ]
            )
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(selectedImage: $selectedImage, sourceType: .photoLibrary)
        }
    }
}

// Custom Image Picker using UIImagePickerController
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    var sourceType: UIImagePickerController.SourceType

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
                parent.selectedImage = image
            }
            picker.dismiss(animated: true)
        }
    }
}


