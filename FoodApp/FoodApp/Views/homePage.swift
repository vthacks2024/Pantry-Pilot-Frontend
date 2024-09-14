//
//  homePage.swift
//  FoodApp
//
//  Created by vthacks on 9/14/24.
//

import Foundation

import SwiftUI
import PhotosUI
import UIKit

struct homePage: View {
    @State private var selectedTab = 0 // Track selected tab
    @State private var isImagePickerPresented = false // Track whether the image picker is presented
    @State private var isCameraPickerPresented = false // Track whether the camera picker is presented
    @State private var selectedImages: [UIImage] = [] // Store up to 5 selected images
    @State private var showImageSourceOptions = false // Track whether to show image source options
    @State private var showError = false // Track whether to show error for max images

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
                            selectedTab = 0
                        }) {
                            VStack {
                                Image(systemName: "photo")
                                    .font(.title)
                                    .foregroundColor(.white) // White icon color
                                Text("Images")
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
                if selectedTab == 0 {
                    AddImage()
                } else if selectedTab == 1 {
                    // Content for "Recipes" Section
                    Recipes()
                } else if selectedTab == 2 {
                    // Content for "Diet" Section
                    Text("Diet Section")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
        }
    }
}


struct homePage_Previews: PreviewProvider {
    static var previews: some View {
        homePage()
    }
}


