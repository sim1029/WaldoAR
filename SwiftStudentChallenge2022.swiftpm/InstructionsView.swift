//
//  InstructionsView.swift
//  SwiftStudentChallenge2022
//
//  Created by Simon Schueller on 4/22/22.
//

import SwiftUI

struct InstructionsView: View {
  @Binding var page: String
  
  var body: some View {
    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
  }
}

struct InstructionsView_Previews: PreviewProvider {
  static var previews: some View {
    InstructionsView(page: .constant("Instructions"))
  }
}
