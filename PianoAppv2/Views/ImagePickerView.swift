//
//  ImagePickerView.swift
//  PianoAppv2
//
//  Created by Rebecca Jackson on 5/10/25.
//

import SwiftUI
import PhotosUI

struct ImagePickerView: View {
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImageData: Data?
    @State private var name: String = ""
    @State private var hp: String = ""
    @State private var artist: String = ""
    @State private var miniboss: Bool = false
    
    var body: some View {
        Form {
            Section(header: Text("Monster Info")) {
                TextField("Name", text: $name)
                TextField("HP", text: $hp)
                    .keyboardType(.numberPad)
                if (!miniboss) {
                    TextField("Artist", text: $artist)
                }
                Toggle(isOn: $miniboss) { Text("Miniboss?")
                }
            }
            
            Section(header: Text("Image")) {
                if let data = selectedImageData, let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                }
                
                PhotosPicker("Select a Photo", selection: $selectedItem)
                    .onChange(of: selectedItem) { newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                selectedImageData = data
                            }
                        }
                    }
            }
            
            Button("Save Monster") {
                
            }
            
            
        }
    }
}


#Preview {
    ImagePickerView()
}
