//
//  FauxTaskView.swift
//  Gouda
//
//  Created by Karl Oscar Weber.
//


import SwiftUI

struct FauxTaskView: View {
    
    var backgroundColor: Color
    var foregroundColor: Color
    var text: String
    
    var body: some View {
        
            let leadingTrailingSpacing: CGFloat = 16
            let standardPadding: CGFloat = 10
            Text(text)
                .fontWeight(.semibold)
                .lineLimit(nil)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 12, leading: (leadingTrailingSpacing), bottom: 12, trailing: leadingTrailingSpacing) )
                
                .foregroundColor(.white)
                .background(backgroundColor)
                .frame(width: .infinity, alignment: .trailing)
                .cornerRadius(20)
                .padding(standardPadding)
    }
}

struct FauxTaskView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
        FauxTaskView(backgroundColor: Color.blue, foregroundColor: Color.black, text: "Try your best, forget the rest, you are the best and I love you the most ever ever rever.")
        FauxTaskView(backgroundColor: Color.blue, foregroundColor: Color.black, text: "Try your best, forget the rest, you are the best and .")
        FauxTaskView(backgroundColor: Color.blue, foregroundColor: Color.black, text: "I want my mommy.")
        }
    }
}
