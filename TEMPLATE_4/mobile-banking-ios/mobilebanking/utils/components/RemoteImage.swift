//
//  RemoteImage.swift
//  maishafiti-uikit
//
//  Created by Daniel Kimani on 02/10/2023.
//

import Foundation
import SwiftUI
import MBCore
import Combine
import URLImage

struct RemoteImage: View {
    
    let imageUrl: String
    var placeholder: String? = "photo_icon"
    
    @State private var uiImage: UIImage? = nil
    
    var body: some View {
        if let uiImage = uiImage {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
        } else {
            //Image("photo_icon")// Placeholder image or loading indicator
            Image(placeholder ?? "photo_icon")// Placeholder image or loading indicator
                .resizable()
                .aspectRatio(contentMode: .fill)
                .onAppear {
                    loadImageFromURL()
                    
                }
        }
    }
    
    
    private func loadImageFromURL() {
        if let encodedUrlString = imageUrl.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
           let url = URL(string: encodedUrlString) {
            let request = URLRequest(url: url)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.uiImage = image
                    }
                }
            }.resume()
        }
    }
    
    
}


struct RemoteImageForEditing: View {

    let imageUrl: String
    @State private var uiImage: UIImage? = nil
    
    
    var body: some View {
        if let uiImage = uiImage {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
        } else {
            // You can display a placeholder image or loading indicator here
            //Text("Loading Image...")
            //Image(systemName: "square.and.pencil.circle")
            if let imageData = UserDefaults.standard.data(forKey: USERDEFAULTS.EDITTED_PROFILE_IMAGE) {
                if let loadedImage = UIImage(data: imageData) {
                    // Use loadedImage as your UIImage
                    Image(uiImage: loadedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .foregroundColor(Color(hexString: CustomColors.blue))
                }
            }else {
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color(hexString: CustomColors.blue))
                    .onAppear {
                        loadImageFromURL()
                    }
            }
        }
    }
    
    
    private func loadImageFromURL() {
        
        if let encodedUrlString = imageUrl.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
           let url = URL(string: encodedUrlString) {
            let request = URLRequest(url: url)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.uiImage = image
                    }
                }
            }.resume()
        }
    }
    
}



/*
struct RemoteImageView: View {
    let imageUrl: String
    @State private var uiImage: UIImage? = nil
    
    var body: some View {
        if let uiImage = uiImage {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
        } else {
            Image(systemName: "person.fill")// Placeholder image or loading indicator
                .resizable()
                .aspectRatio(contentMode: .fill)
                .onAppear {
                    loadImageFromURL()
                }
        }
    }
    
    private func loadImageFromURL() {
        if let encodedUrlString = imageUrl.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
           let url = URL(string: encodedUrlString) {
            let request = URLRequest(url: url)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.uiImage = image
                    }
                }
            }.resume()
        }
    }
    
}

*/




struct RemoteURLImage: View {
    let imageUrl: String?
    //let imageUrl: URL?
    let placeholder: Image
    let aspectRatio: ContentMode
    
    init(imageUrl: String?, placeholder: Image = Image(systemName: "person.fill"), aspectRatio: ContentMode = ContentMode.fill) {
        self.imageUrl = imageUrl
        self.placeholder = placeholder
        self.aspectRatio = aspectRatio
    }
    
    var body: some View {
        VStack{
            if let imageUrl = URL(string: imageUrl ?? "") {
                URLImage(imageUrl) {
                    // This view is displayed before download starts
                    //EmptyView()
                    //Image("person_icon")
                    placeholder
                        .resizable()
                        .aspectRatio(contentMode: aspectRatio)
                       
                } inProgress: { progress in
                    // Display progress
                    placeholder
                        .resizable()
                        .aspectRatio(contentMode: aspectRatio)
                       // .scaledToFit()
                    //.foregroundColor(Color(hexString: CustomColors.blue))
                } failure: { error, retry in
                    // Display error and retry button
                    placeholder
                        .resizable()
                        .aspectRatio(contentMode: aspectRatio)
                        //.scaledToFit()
                    //.foregroundColor(Color(hexString: CustomColors.blue))
                } content: { image in
                    // Downloaded image
                    image
                        .resizable()
                        .aspectRatio(contentMode: aspectRatio)
                        //.frame(maxHeight: 300)
                }
            }else{
                placeholder
                    .resizable()
                    .aspectRatio(contentMode: aspectRatio)
                    //.scaledToFit()
                    .foregroundColor(Color(hexString: CustomColors.blue))
                
            }
        }.padding(2)
    }
}




