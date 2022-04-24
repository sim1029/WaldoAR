//
//  InstructionView.swift
//  SwiftStudentChallenge2022
//
//  Created by Simon Schueller on 4/23/22.
//

import SwiftUI

struct InstructionView: View {
  var instructionTitle: String
  var instructionImage: UIImage
  var instructionDescription: String
  
    var body: some View {
      
      ZStack {
        Color.blue.ignoresSafeArea()
        VStack {
          HStack {
            Text(instructionTitle)
              .font(.largeTitle)
              .fontWeight(.bold)
              .padding()
            Spacer()
          }
          .padding()
          
          
          Image(uiImage: instructionImage)
            .resizable()
            .frame(width: 250, height: 250)
            .padding()
          
          Text(instructionDescription)
            .font(.body)
            .lineSpacing(20)
            .padding()
          
          Spacer()
        }
        .foregroundColor(.white)
      }
    }
}

struct InstructionView_Previews: PreviewProvider {
    static var previews: some View {
      InstructionView(instructionTitle: "Gameplay", instructionImage: UIImage(named: "plans")!, instructionDescription: "Quick! before the ticking timer runs out, tap on only the emojis I tell you to advance levels.")
    }
}
