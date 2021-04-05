//
//  ListRowView.swift
//  Gouda
//
//  Created by Karl Weber on 4/5/21.
//

import SwiftUI

struct ListRowView: View {
  
  @State var viewState = CGSize.zero
  
  var position: Int
  var title: String
  
    var body: some View {
      
      ZStack {
        GeometryReader { geometry in
         
          HStack {
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: .continuous)
              .animation(.spring())
              .frame(width: geometry.size.width, height: geometry.size.height)
              .foregroundColor( viewState.width > 35 ? Color.blue : Color.white )
          }
          
          Text("\(position) \(title)")
            .padding()
            .frame(width: geometry.size.width, height: geometry.size.height,
                   alignment: .leading)
            .background(Color.white)
            .offset(x: viewState.width, y: 0)
            .animation(.spring())
            .gesture(
              DragGesture()
                .onChanged { value in
                  if value.translation.width < 100 && value.translation.width > 0 {
                  self.viewState = value.translation
                  }
                }
                .onEnded { value in
                  self.viewState = .zero
                }
            )
          
        }
      }
      
        
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
      ListRowView(position: 1000, title: "#Next")
    }
}
