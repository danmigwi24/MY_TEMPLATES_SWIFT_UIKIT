//
//  CustomPagingView.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 29/02/2024.
//

import Foundation
import SwiftUI
import MBCore


struct PagingView<Content>: View where Content: View {

    @Binding var index: Int
    var title: String
    let maxIndex: Int
    let content: () -> Content

    @State private var offset = CGFloat.zero
    @State private var dragging = false

    init(index: Binding<Int>,title:String, maxIndex: Int, @ViewBuilder content: @escaping () -> Content) {
        self._index = index
        self.title = title
        self.maxIndex = maxIndex
        self.content = content
    }

    var body: some View {
        //ZStack(alignment: .bottomTrailing) {
        VStack(spacing: 0) {
            HStack{
                CustomTextSemiBold(text: title, textColor: Color(hexString: CustomColors.darkBlue), fontSize: 14, textAlignment: .leading).vSpacingWithMaxWidth(.leading)
                
                PageControl(index: $index, maxIndex: maxIndex)
            }
            GeometryReader { geometry in
                let width = geometry.size.width * 0.8
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        self.content()
                            .frame(width: width, height: geometry.size.height)
                            //.clipped()
                    }
                }
                .content.offset(x: self.offset(in: geometry, width: width), y: 0)
                .frame(width: width, alignment: .leading)
                .gesture(
                    DragGesture().onChanged { value in
                        self.dragging = true
                        self.offset = -CGFloat(self.index) * width + value.translation.width
                    }
                    .onEnded { value in
                        let predictedEndOffset = -CGFloat(self.index) * width + value.predictedEndTranslation.width
                        let predictedIndex = Int(round(predictedEndOffset / -width))
                        self.index = self.clampedIndex(from: predictedIndex)
                        withAnimation(.easeOut) {
                            self.dragging = false
                        }
                    }
                )
            }
            //.clipped()

         
        }
    }

    func offset(in geometry: GeometryProxy,width:CGFloat) -> CGFloat {
        if self.dragging {
            //return max(min(self.offset, 0), -CGFloat(self.maxIndex) * geometry.size.width)
            return max(min(self.offset, 0), -CGFloat(self.maxIndex) * width)
        } else {
            return -CGFloat(self.index) * width//geometry.size.width
        }
    }

    func clampedIndex(from predictedIndex: Int) -> Int {
        let newIndex = min(max(predictedIndex, self.index - 1), self.index + 1)
        guard newIndex >= 0 else { return 0 }
        guard newIndex <= maxIndex else { return maxIndex }
        return newIndex
    }
    
    @ViewBuilder
    func PageControl(index: Binding<Int>,maxIndex: Int) -> some View {
        HStack(spacing: 8) {
            ForEach(0...maxIndex, id: \.self) { index in
                Circle()
                    .fill(index == self.index ? Color.blue : Color.gray)
                    .frame(width: 8, height: 8)
            }
        }
        .padding(15)
    }
}



/*
 //https://stackoverflow.com/questions/58896661/swiftui-create-image-slider-with-dots-as-indicators
 struct PagingView<Content>: View where Content: View {

     @Binding var index: Int
     let maxIndex: Int
     let content: () -> Content

     @State private var offset = CGFloat.zero
     @State private var dragging = false

     init(index: Binding<Int>, maxIndex: Int, @ViewBuilder content: @escaping () -> Content) {
         self._index = index
         self.maxIndex = maxIndex
         self.content = content
     }

     var body: some View {
         ZStack(alignment: .bottomTrailing) {
             GeometryReader { geometry in
                 ScrollView(.horizontal, showsIndicators: false) {
                     HStack(spacing: 0) {
                         self.content()
                             .frame(width: geometry.size.width, height: geometry.size.height)
                             .clipped()
                     }
                 }
                 .content.offset(x: self.offset(in: geometry), y: 0)
                 .frame(width: geometry.size.width, alignment: .leading)
                 .gesture(
                     DragGesture().onChanged { value in
                         self.dragging = true
                         self.offset = -CGFloat(self.index) * geometry.size.width + value.translation.width
                     }
                     .onEnded { value in
                         let predictedEndOffset = -CGFloat(self.index) * geometry.size.width + value.predictedEndTranslation.width
                         let predictedIndex = Int(round(predictedEndOffset / -geometry.size.width))
                         self.index = self.clampedIndex(from: predictedIndex)
                         withAnimation(.easeOut) {
                             self.dragging = false
                         }
                     }
                 )
             }
             .clipped()

             PageControl(index: $index, maxIndex: maxIndex)
         }
     }

     func offset(in geometry: GeometryProxy) -> CGFloat {
         if self.dragging {
             return max(min(self.offset, 0), -CGFloat(self.maxIndex) * geometry.size.width)
         } else {
             return -CGFloat(self.index) * geometry.size.width
         }
     }

     func clampedIndex(from predictedIndex: Int) -> Int {
         let newIndex = min(max(predictedIndex, self.index - 1), self.index + 1)
         guard newIndex >= 0 else { return 0 }
         guard newIndex <= maxIndex else { return maxIndex }
         return newIndex
     }
 }
 
 struct PageControl: View {
     @Binding var index: Int
     let maxIndex: Int

     var body: some View {
         HStack(spacing: 8) {
             ForEach(0...maxIndex, id: \.self) { index in
                 Circle()
                     .fill(index == self.index ? Color.white : Color.gray)
                     .frame(width: 8, height: 8)
             }
         }
         .padding(15)
     }
 }
 
 */
