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
                    AddImage()
                } else if selectedTab == 1 {
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
        
        
    }
}



