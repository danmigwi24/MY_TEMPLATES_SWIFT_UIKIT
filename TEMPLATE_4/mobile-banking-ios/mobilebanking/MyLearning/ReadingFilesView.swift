//
//  ReadingFilesView.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 09/02/2024.
//

import SwiftUI
import MBCore



// MARK:
struct PostsElement: Codable, Hashable {
    let userID: Int?
    let id: Int?
    let title: String?
    let body: String?
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id = "id"
        case title = "title"
        case body = "body"
    }
    
    static var SamplePostElements: [PostsElement] = Bundle.main.decodeFiled(file: "posts.json")
}

struct ReadingFilesView: View {
    
    @StateObject private var vm = PostViewModel(testMode: false)
    
    var body: some View {
        VStack{
            GeometryReader { geometry in
                //
                LoadingView(isShowing: self.$vm.isLoading) {
                    VStack{
                    Text("POST DATA")
                        List{
                            ForEach(vm.postsElement,id: \.self){ item in
                                Text(item.title ?? "")
                            }
                        }
                    }
                }
            }
        }
        .task {
            //vm.makeFakeApiRequest()
            //vm.makeApiRequest()
            vm.makeApiRequestWithCombine()
        }
        .refreshable {
            //vm.makeFakeApiRequest()
            //vm.makeApiRequest()
            vm.makeApiRequestWithCombine()
        }
        
    }
}

struct ReadingFilesView_Previews: PreviewProvider {
    static var previews: some View {
        ReadingFilesView()
    }
}
