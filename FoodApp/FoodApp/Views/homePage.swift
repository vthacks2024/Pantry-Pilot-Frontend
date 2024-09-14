//
//  homePage.swift
//  FoodApp
//
//  Created by vthacks on 9/14/24.
//
import SwiftUI
import UIKit

struct homePage: View {
    @State private var selectedTab = 1 // Track selected tab
    @State private var isImagePickerPresented = false // Track whether the image picker is presented
    @State private var isCameraPickerPresented = false // Track whether the camera picker is presented
    @State private var selectedImage: UIImage? // Store the selected image
    @State private var showImageSourceOptions = false // Track whether to show image source options

    var body: some View {
        VStack(spacing: 0) {
            // Header with background and rounded bottom edges
            ZStack {
                // Background with rounded bottom edges
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color.green.opacity(0.6)) // Light green background color
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: 140) // Fixed height to contain all elements

                // Header content (Title and Tabs)
                VStack {
                    // Header title
                    Text("Welcome, User")
                        .font(.title)
                        .foregroundColor(.white) // White text color
                        .padding(.top, 20) // Top padding for title

                    // Tabs
                    HStack(spacing: 20) {
                        // Tab 1: Images
                        Button(action: {
                            showImageSourceOptions = true // Show action sheet for image source options
                        }) {
                            VStack {
                                Image(systemName: "photo")
                                    .font(.title)
                                    .foregroundColor(.white) // White icon color
                                Text("Add Image")
                                    .font(.caption)
                                    .foregroundColor(.white) // White text color
                            }
                        }
                        .frame(maxWidth: .infinity)

                        // Tab 2: Recipes
                        Button(action: {
                            selectedTab = 1
                        }) {
                            VStack {
                                Image(systemName: "book")
                                    .font(.title)
                                    .foregroundColor(.white) // White icon color
                                Text("Recipes")
                                    .font(.caption)
                                    .foregroundColor(.white) // White text color
                            }
                        }
                        .frame(maxWidth: .infinity)

                        // Tab 3: Diet
                        Button(action: {
                            selectedTab = 2
                        }) {
                            VStack {
                                Image(systemName: "leaf")
                                    .font(.title)
                                    .foregroundColor(.white) // White icon color
                                Text("Diet")
                                    .font(.caption)
                                    .foregroundColor(.white) // White text color
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.vertical, 10) // Padding for the tabs
                }
                .padding(.horizontal, 20) // Padding on left and right
            }
            .padding(.bottom, -10) // Adjusts padding below the header to align with the divider
            
            // Content Area Below the Divider
            VStack {
                if selectedTab == 1 {
                    // Content for "Recipes" Section
                    Recipes()
                } else if selectedTab == 2 {
                    // Content for "Diet" Section
                    DietaryRestrictions()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
        }
        .actionSheet(isPresented: $showImageSourceOptions) { // Action sheet to choose image source
            ActionSheet(
                title: Text("Choose Image Source"),
                message: Text("Select an image from your photo library or take a new one."),
                buttons: [
                    .default(Text("Camera")) {
                        isImagePickerPresented = true
                        isCameraPickerPresented = true // Set the source type to camera
                    },
                    .default(Text("Photo Library")) {
                        isImagePickerPresented = true
                        isCameraPickerPresented = false // Set the source type to photo library
                    },
                    .cancel()
                ]
            )
        }
        .sheet(isPresented: $isImagePickerPresented) { // Present the image picker sheet
            CustomImagePicker(selectedImage: $selectedImage, sourceType: isCameraPickerPresented ? .camera : .photoLibrary)
        }
    }
}

// Custom Image Picker using UIImagePickerController
struct CustomImagePicker: UIViewControllerRepresentable {
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
        var parent: CustomImagePicker

        init(_ parent: CustomImagePicker) {
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
