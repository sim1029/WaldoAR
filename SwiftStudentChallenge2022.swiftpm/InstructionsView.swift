//
//  InstructionsView.swift
//  SwiftStudentChallenge2022
//
//  Created by Simon Schueller on 4/22/22.
//

import SwiftUI

struct InstructionsView: View {
  var instructions: [InstructionView] = [
    InstructionView(instructionTitle: "Move to open space", instructionImage: UIImage(named: "plans")!, instructionDescription: "Moving to a room or outdoor space alows Emoji Hunt to render the best AR experience possible"),
    InstructionView(instructionTitle: "Introduction", instructionImage: UIImage(named: "help")!, instructionDescription: "Help! my emojis have escaped my keyboard and entered your reality. I need to recapture them to the keyboard but in a very particular order. Could you help me?"),
    InstructionView(instructionTitle: "Gameplay", instructionImage: UIImage(named: "joystick")!, instructionDescription: "Quick! before the ticking timer runs out, tap on only the emojis I tell you to advance levels."),
    InstructionView(instructionTitle: "Warning", instructionImage: UIImage(named: "alert")!, instructionDescription: "These emojis are excelent hiders, but please dont get sick spining in circles racing against that clock!"),
    InstructionView(instructionTitle: "Have Fun!", instructionImage: UIImage(named: "party")!, instructionDescription: "I am searching for the most skilled emoji hunters to join my team. Get out there and set some high scores hunter!"),
  ]
  @State var currInstruction: Int = 0
  
  var body: some View {
    ZStack {
      Color.blue.ignoresSafeArea()
      VStack {
        instructions[currInstruction]
        if instructions[currInstruction].instructionTitle != "Have Fun!" {
          HStack {
            Spacer()
            Button (action: {currInstruction += 1}) {
              HStack {
                Text("Next")
                  .font(.title2)
                Image(systemName: "hand.point.right.fill")
                  .imageScale(.large)
              }
            }
          }.padding(25)
        }
      }
      .foregroundColor(.white)
    }
  }
}

struct InstructionsView_Previews: PreviewProvider {
  static var previews: some View {
    InstructionsView()
  }
}
