//
//  SequenceComposeView.swift
//  Gouda
//
//  Created by Karl Oscar Weber.
//


import SwiftUI

struct SequenceComposeView: View {
    
    @State var viewState = CGSize.zero
    @State var canBeDragged = false
    @State var translation: CGSize = .zero
    
    var body: some View {
        
        let longTapGesture = LongPressGesture(minimumDuration: 0.5).onEnded { _ in
            self.canBeDragged = true
        }
        let dragGesture = DragGesture().onChanged { (value) in
            self.translation = value.translation
            self.canBeDragged = true
        }.onEnded { (value) in
//            self.viewState.width += value.translation.width
            self.viewState.height += value.translation.height
            self.translation = .zero
            self.canBeDragged = false
        }
        
        let longTapBeforeDragGestures = longTapGesture.sequenced(before: dragGesture)
        
        var animation: Animation {
            Animation.easeInOut
        }
        
        return Circle()
            .fill(Color.blue)
            .overlay(canBeDragged ? Circle().stroke(Color.gray, lineWidth: 2) : nil)
            .scaleEffect(canBeDragged ? 1.2 : 1)
            .animation(.interactiveSpring(response: 0.1, dampingFraction: 1.2, blendDuration: 0.37))
            .frame(width: 100, height: 100, alignment: .center)
            .offset(
                x: viewState.width,
                y: viewState.height + translation.height
            )
            .shadow(radius: canBeDragged ? 8 : 0)
            .gesture(longTapBeforeDragGestures)
        
    
    }
}

struct SequenceComposeView_Previews: PreviewProvider {
    static var previews: some View {
        SequenceComposeView()
    }
}


struct Sizes: PreferenceKey {
   typealias Value = [CGRect]
    static var defaultValue: [CGRect] = []
    
    static func reduce(value: inout [CGRect], nextValue: () -> [CGRect]) {
        value.append(contentsOf: nextValue())
    }
}

struct SizeReader: View {
    var body: some View {
        GeometryReader { proxy in
            Color.clear
                .preference(key: Sizes.self, value: [proxy.frame(in: .global)])
        }
    }
}
