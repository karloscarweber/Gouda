//
//  RoundedButtonView.swift
//  Gouda
//
//  Created by Karl Weber on 4/3/21.
//

import SwiftUI

struct RoundedButtonView: View {
  
  var text: String
  
    var body: some View {
      Text(text)
        .bold()
        .frame(width: 225, height: 44)
        .foregroundColor(Color.white)
        .background(Color.blue)
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 22, height: 22), style: RoundedCornerStyle.continuous)  )
    }
}

struct RoundedButtonView_Previews: PreviewProvider {
    static var previews: some View {
      RoundedButtonView(text: "Add List")
    }
}
