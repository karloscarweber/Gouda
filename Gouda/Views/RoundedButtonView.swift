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
        .frame(width: 255, height: 54)
        .foregroundColor(Color.white)
        .background(Color.blue)
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 27, height: 27), style: RoundedCornerStyle.continuous)  )
    }
}

struct RoundedButtonView_Previews: PreviewProvider {
    static var previews: some View {
      RoundedButtonView(text: "Add List")
    }
}
