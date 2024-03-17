//
//  ImagePicker.swift
//  maishafiti-uikit
//
//  Created by Daniel Kimani on 04/10/2023.
//

import Foundation
import SwiftUI
import MBCore

struct ImagePicker: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIImagePickerController
    typealias Coordinator = ImagePickerCoordinator
    
    @Binding var image: UIImage?
    @Binding var isShown: Bool
    var sourceType: UIImagePickerController.SourceType = .camera
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }
    
    func makeCoordinator() -> ImagePicker.Coordinator {
        return ImagePickerCoordinator(image: $image, isShown: $isShown)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
        
    }
    
    
    class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        @Binding var image: UIImage?
        @Binding var isShown: Bool
        
        init(image: Binding<UIImage?>, isShown: Binding<Bool>) {
            _image = image
            _isShown = isShown
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                image = uiImage
                isShown = false
            }
            
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            isShown = false
        }
        
    }
    
}

struct ImagePickerForSingleImage: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    //@Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // Update the view controller if needed
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePickerForSingleImage
        
        init(_ parent: ImagePickerForSingleImage) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                parent.selectedImage = selectedImage
            }
            picker.dismiss(animated: true)
           // parent.presentationMode.wrappedValue.dismiss()
        }
    }
}



//MARK: IMAGEPICKER FOR LIST OF IMAGES
struct ImagePickerForListOfImages: UIViewControllerRepresentable {
    @Binding var images: [UIImage]
    @Binding var selectedImageIndex: Int?

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerForListOfImages>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        //imagePicker.sourceType = .camera
        imagePicker.sourceType = .photoLibrary
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePickerForListOfImages>) {
        // Update the view controller if needed
    }

    func makeCoordinator() -> CoordinatorForListOfImages {
        CoordinatorForListOfImages(self)
    }

    class CoordinatorForListOfImages: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePickerForListOfImages

        init(_ parent: ImagePickerForListOfImages) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.images.append(image)
            }
            picker.dismiss(animated: true)
        }
    }
}

