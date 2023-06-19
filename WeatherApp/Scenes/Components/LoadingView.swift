//
//  LoadingView.swift
//  WeatherApp
//
//  Created by Anil 2023
//
import SwiftUI

struct LoadingView<Content>: View where Content: View {
    @Binding var isShowing: Bool
    @Binding var text: String
    var content: () -> Content

    
    var body: some View {
            ZStack(alignment: .center) {
                self.content()
                    .disabled(self.isShowing)
                VStack {
                    if !self.text.isEmpty {
                        ActivityIndicator(isAnimating: .constant(true), style: .large)
                            .padding(.top)
                        Text(self.text)
                            .padding([.leading, .trailing, .bottom])
                    } else {
                        ActivityIndicator(isAnimating: .constant(true), style: .large)
                    }
                }
                .frame(minWidth: 78,
                       idealWidth: nil,
                       maxWidth: nil,
                       minHeight: 78,
                       idealHeight: nil,
                       maxHeight: nil,
                       alignment: .center)
                .cornerRadius(6)
                .opacity(self.isShowing ? 1 : 0)
            }
    }
    
}
