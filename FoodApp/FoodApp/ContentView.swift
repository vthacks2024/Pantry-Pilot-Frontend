//
//  ContentView.swift
//  FoodApp
//
//  Created by Eric Jung on 9/14/24.
//
import SwiftUI
import PhotosUI
import UIKit


import SwiftUI
import PhotosUI
import UIKit

struct ContentView: View {
    @State private var selectedTab = 0 // Track selected tab
    @State private var isImagePickerPresented = false // Track whether the image picker is presented
    @State private var isCameraPickerPresented = false // Track whether the camera picker is presented
    @State private var selectedImages: [UIImage] = [] // Store up to 5 selected images
    @State private var showImageSourceOptions = false // Track whether to show image source options
    @State private var showError = false // Track whether to show error for max images

    var body: some View {
        VStack(spacing: 0) { // Remove spacing between VStack elements
            // Header
            Text("Welcome, User")
                .font(.largeTitle)
                .padding(.top, 60) // Increased top padding for more margin

            // Tabs
            HStack {
                // Tab 1: Images
                Button(action: {
                    selectedTab = 0
                }) {
                    VStack {
                        Image(systemName: "photo")
                            .font(.largeTitle)
                        Text("Images")
                            .font(.caption)
                    }
                }
                .foregroundColor(selectedTab == 0 ? .blue : .gray)
                .frame(maxWidth: .infinity)

                // Tab 2: Recipes
                Button(action: {
                    selectedTab = 1
                }) {
                    VStack {
                        Image(systemName: "book")
                            .font(.largeTitle)
                        Text("Recipes")
                            .font(.caption)
                    }
                }
                .foregroundColor(selectedTab == 1 ? .blue : .gray)
                .frame(maxWidth: .infinity)
                
                // Tab 3: Diet
                Button(action: {
                    selectedTab = 2
                }) {
                    VStack {
                        Image(systemName: "leaf")
                            .font(.largeTitle)
                        Text("Diet")
                            .font(.caption)
                    }
                }
                .foregroundColor(selectedTab == 2 ? .blue : .gray)
                .frame(maxWidth: .infinity)
            }
            .padding(.top)
            
            // Full-width Divider
            Divider()
                .frame(height: 1) // Set the height of the divider
                .background(Color.gray) // Set the color of the divider to gray
                .padding(.horizontal, -20) // Extend the divider to cover the entire width
            
            // Content Area Below the Divider
            VStack {
                if selectedTab == 0 {
                    // Content for "Images" Section
                    VStack {
                        if selectedImages.count < 5 {
                            Button(action: {
                                showImageSourceOptions = true // Show options to select source
                            }) {
                                HStack {
                                    Image(systemName: "plus.circle")
                                        .font(.title)
                                    Text("Upload Image")
                                        .font(.headline)
                                }
                            }
                            .padding()
                        } else {
                            Text("Maximum of 5 images reached")
                                .foregroundColor(.red)
                                .padding()
                        }

                        // Display selected images
                        ForEach(selectedImages.indices, id: \.self) { index in
                            ZStack(alignment: .topTrailing) {
                                Image(uiImage: selectedImages[index])
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 200)
                                    .padding()
                                
                                // Remove button on each image
                                Button(action: {
                                    selectedImages.remove(at: index)
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.red)
                                        .padding()
                                }
                            }
                        }
                    }
                    .alert(isPresented: $showError) {
                        Alert(title: Text("Error"), message: Text("You can only upload up to 5 images."), dismissButton: .default(Text("OK")))
                    }
                } else if selectedTab == 1 {
                    // Content for "Recipes" Section
                    Text("Recipes Section")
                        .font(.title)
                        .padding()
                } else if selectedTab == 2 {
                    // Content for "Diet" Section
                    Text("Diet Section")
                        .font(.title)
                        .padding()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
        }
        .background(Color.white) // Set the whole view background to white
        .edgesIgnoringSafeArea(.all) // Make sure the background covers the whole screen
        .sheet(isPresented: $isImagePickerPresented) {
            // Present the image picker for Photo Library
            ImagePicker(selectedImages: $selectedImages, sourceType: .photoLibrary)
        }
        .sheet(isPresented: $isCameraPickerPresented) {
            // Present the image picker for Camera
            ImagePicker(selectedImages: $selectedImages, sourceType: .camera)
        }
        .actionSheet(isPresented: $showImageSourceOptions) {
            ActionSheet(
                title: Text("Choose Image Source"),
                message: Text("Select an image from your photo library or take a new one."),
                buttons: [
                    .default(Text("Camera")) {
                        if selectedImages.count < 5 {
                            isCameraPickerPresented = true // Show camera picker
                        } else {
                            showError = true // Show error if max images reached
                        }
                    },
                    .default(Text("Photo Library")) {
                        if selectedImages.count < 5 {
                            isImagePickerPresented = true // Show photo library picker
                        } else {
                            showError = true // Show error if max images reached
                        }
                    },
                    .cancel()
                ]
            )
        }
    }
}

// Custom Image Picker using UIImagePickerController
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImages: [UIImage]
    var sourceType: UIImagePickerController.SourceType

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                if parent.selectedImages.count < 5 {
                    parent.selectedImages.append(image)
                }
            }
            picker.dismiss(animated: true)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
