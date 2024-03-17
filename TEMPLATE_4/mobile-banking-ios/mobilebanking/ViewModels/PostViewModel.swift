//
//  PostViewModel.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 10/02/2024.
//

import Foundation
import Combine




final class PostViewModel : ObservableObject {
    
    @Published var isLoading:Bool = false
    @Published var postsElement = [PostsElement]()
    
    private let baseUrl = "https://jsonplaceholder.typicode.com/posts"
    //private let apiManager = ApiManger()
    private var cancellables = Set<AnyCancellable>()
    @Published var errorMessage: String?
    
    init(testMode:Bool){
        //testMode ? makeFakeApiRequest() : makeApiRequest()
    }
    
    func makeApiRequest(){
        isLoading = true
        //[weak self] - prevent memory leaks
        /*
        apiManager.getData(url: baseUrl, model: [PostsElement].self) { [weak self]  result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch(result){
                case .success(let response):
                    self?.postsElement = response
                case .failure(let error):
                    let errorResonse = PostsElement(userID: 0, id: 0, title: "Errro", body: "Error")
                    self?.postsElement = [errorResonse]
                    print(error)
                }
            }
        }
        */
    }
    
    func makeApiRequestWithCombine(){
        isLoading = true
        //[weak self] - prevent memory leaks
        /*
        apiManager.getDataCombine(url: baseUrl, model: [PostsElement].self)
                   .receive(on: DispatchQueue.main) // Receive on the main thread to update UI
                   .sink { completion in
                       switch completion {
                       case .finished:
                           self.isLoading = false
                           break
                       case .failure(let error):
                           self.errorMessage = error.localizedDescription
                       }
                   } receiveValue: { yourModel in
                       self.postsElement = yourModel
                   }
                   .store(in: &cancellables)
         */
    }
   
    func makeFakeApiRequest(){
        self.postsElement = PostsElement.SamplePostElements
    }
    
}
